import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/general/add_walk.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/models/walk.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class WalkList extends StatefulWidget {
  final Pet pet;
  const WalkList({Key? key, required this.pet}) : super(key: key);

  @override
  State<WalkList> createState() => _WalkListState();
}

class _WalkListState extends State<WalkList> {
  late List<Walk> walkList;
  late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late Pet pet;
  late DateTime walkDate;
  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  late int walkHourRemined;
  late int walkMinuteRemined;
  void initState() {
    pet = widget.pet;
    walkList = widget.pet.walk;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Walk"),
      ),
      body: Column(
        children: [
          Container(
            child: ListTile(
                leading: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Icon(
                    FontAwesomeIcons.walking,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                    text: '   Walk',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )),
              ]),
            )),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: walkList.length,
                padding: const EdgeInsets.all(5.0),
                separatorBuilder: (context, index) => Divider(
                      height: 2.0,
                      color: Colors.black87,
                    ),
                itemBuilder: (context, index) {
                  final item = walkList[index].date;
                  return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.white),
                              Text('Edit',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              Text('Delete',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Confirmation"),
                                content: const Text(
                                    "Are you sure you want to delete this walk?"),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("Delete")),
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (direction == DismissDirection.startToEnd) {
                          return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: const Text('Walk'),
                                    content: SingleChildScrollView(
                                      child: Form(
                                        key: _formKey,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          children: <Widget>[
                                            DatePicker(
                                                name: 'Date',
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Enter the Vaccination Date';
                                                  }
                                                },
                                                onChanged: (text) {
                                                  walkDate = text;
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              Navigator.of(context).pop();
                                              repository.updateVaccin(
                                                  pet, index);
                                              // repository.updatePet(widget.pet);
                                            }
                                            //widget.callback();
                                          },
                                          child: const Text('Update')),
                                    ]);
                              });
                        }
                      },
                      onDismissed: (direction) {
                        setState(() {
                          if (direction == DismissDirection.startToEnd) {
                            print('');
                          } else {
                            walkList.removeAt(index);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item deleted')));
                      },
                      child: ListTile(
                          title: Text(dateFormat.format(item)),
                          subtitle: Text(dateFormat
                                  .format(walkList[index].date) +
                              ' at ${walkList[index].hour}:${walkList[index].minutes > 9 ? walkList[index].minutes : '0' + (walkList[index].minutes).toString()}')));
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 0, 40),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'I want to walk my dog:',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 3,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    content: Wrap(
                                                        alignment: WrapAlignment
                                                            .center,
                                                        spacing: 3,
                                                        children: [
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child:
                                                            Text("Choose Time"),
                                                      )
                                                    ]));
                                              });
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.blue,
                                          ),
                                        ),
                                        child: Text("Once"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    content: Wrap(
                                                        alignment: WrapAlignment
                                                            .center,
                                                        spacing: 3,
                                                        children: [
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            "   Choose Time for first walking   "),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            "Choose Time for second walking"),
                                                      ),
                                                    ]));
                                              });
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.blue,
                                          ),
                                        ),
                                        child: Text("Twice"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    content: Wrap(
                                                        alignment: WrapAlignment
                                                            .center,
                                                        spacing: 3,
                                                        children: [
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            "    Choose Time for first walking    "),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            " Choose Time for second walking "),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            "   Choose Time for third walking   "),
                                                      ),
                                                    ]));
                                              });
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.blue,
                                          ),
                                        ),
                                        child: Text("3 times"),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Icon(
                          Icons.doorbell,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 40),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: const TextStyle(fontSize: 16)),
                        onPressed: () async {
                          cancelScheduleNotifcations();
                        },
                        child: Row(
                          children: [
                            Text("Cancel Notifications "),
                            const Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _addWalk(widget.pet, () {
            setState(() {});
          });
        },
        tooltip: 'Add Walk',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addWalk(Pet pet, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddWalk(pet: pet, callback: callback);
        });
  }

  Future<void> _selectTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      setState(() {
        walkHourRemined = timeOfDay.hour;
        walkMinuteRemined = timeOfDay.minute;
      });
    }
    createWalkNotificationEveryDay(walkHourRemined, walkMinuteRemined, pet);
  }
}
