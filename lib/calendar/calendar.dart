import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/calendar/event.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_health_app/services/auth.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  //late CalendarController _controller;
  CalendarFormat format = CalendarFormat.month;
  late Map<DateTime, List<Event>> selectedEvents;
  TextEditingController _eventController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataRepository repository = DataRepository();
  late User? user;
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    user = auth.currentUser;
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  // Future<List<Event>> _getEventsfromDay(DateTime date) async {
  //   List<Event> list = List<Event>.empty(growable: true);
  //   var data = await FirebaseFirestore.instance
  //       .collection('event')
  //       .where("date", isEqualTo: date)
  //       .get();
  //   for (var element in data.docs) {
  //     list.add(Event.fromJson(element.data() as Map<String, dynamic>));
  //   }
  //   return list;
  //   //return selectedEvents[date] ?? [];
  // }
  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  late int eventHour;
  late int eventMinutes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('event').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekVisible: true,
                    //Day Changed
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                      print(focusedDay);
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    eventLoader: _getEventsfromDay,
                    //To style the Calendar
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      defaultDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      weekendDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      formatButtonShowsNext: false,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // ..._buildList(context, snapshot.data?.docs ?? [])
                  ..._getEventsfromDay(selectedDay).map((Event event) => ListTile(
                      title: Text(event.title),
                      subtitle: Text(
                          'at ${event.hour}:${event.minutes > 9 ? event.minutes : '0' + (event.minutes).toString()}')))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _eventController,
                    ),
                    ElevatedButton(
                      onPressed: _selectTime,
                      child: Text("Choose Time"),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  if (_eventController.text.isEmpty) {
                  } else {
                    final User? user = auth.currentUser;
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(
                          title: _eventController.text,
                          date: selectedDay,
                          hour: eventHour,
                          minutes: eventMinutes,
                          uid: user!.uid,
                        ),
                      );
                      final newEvent = Event(
                        title: _eventController.text,
                        date: selectedDay,
                        hour: eventHour,
                        minutes: eventMinutes,
                        uid: user!.uid,
                      );
                      repository.addEvent(newEvent);
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(
                          title: _eventController.text,
                          date: selectedDay,
                          hour: eventHour,
                          minutes: eventMinutes,
                          uid: user!.uid,
                        )
                      ];
                      final newEvent = Event(
                        title: _eventController.text,
                        date: selectedDay,
                        hour: eventHour,
                        minutes: eventMinutes,
                        uid: user.uid,
                      );
                      repository.addEvent(newEvent);
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        icon: Icon(Icons.add),
        label: Text("Add Event"),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      setState(() {
        eventHour = timeOfDay.hour;
        eventMinutes = timeOfDay.minute;
      });
    }
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(data)).toList(),
    );
  }

  Widget _buildListItem(DocumentSnapshot snapshot) {
    final User? user = auth.currentUser;
    final event = Event.fromSnapshot(snapshot);
    if (event.uid == user!.uid) {
      return ListTile(
          title: Text(event.title),
          subtitle: Text(
              'at ${event.hour}:${event.minutes > 9 ? event.minutes : '0' + (event.minutes).toString()}'));
    }
    return SizedBox.shrink();
  }
}
