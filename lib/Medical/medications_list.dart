import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/Medical/add_medication.dart';
import 'package:pet_health_app/models/medication.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class MedicationList extends StatefulWidget {
  final Pet pet;
  const MedicationList({Key? key, required this.pet}) : super(key: key);

  @override
  State<MedicationList> createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  late List<Medication> medicationList;
  late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late Pet pet;
  late DateTime medicationDate;
  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  late int medicationHourRemined;
  late int medicationMinuteRemined;
  void initState() {
    pet = widget.pet;
    medicationList = widget.pet.medications;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Medications"),
      ),
      body: Column(
        children: [
          Container(
            child: ListTile(
                leading: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Icon(
                    FontAwesomeIcons.pills,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                    text: '   Medications',
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
                itemCount: medicationList.length,
                padding: const EdgeInsets.all(5.0),
                separatorBuilder: (context, index) => Divider(
                      height: 2.0,
                      color: Colors.black87,
                    ),
                itemBuilder: (context, index) {
                  final item = medicationList[index].date;
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
                                    "Are you sure you want to delete this medication?"),
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
                                    title: const Text('Medication'),
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
                                                    return 'Enter the Medication Date';
                                                  }
                                                },
                                                onChanged: (text) {
                                                  medicationDate = text;
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
                            medicationList.removeAt(index);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item deleted')));
                      },
                      child: ListTile(
                          title: Text(
                              (medicationList[index].amount).toString() +
                                  " gr of " +
                                  medicationList[index].medicationName +
                                  " given at " +
                                  dateFormat.format(item)),
                          subtitle: Text(dateFormat
                                  .format(medicationList[index].date) +
                              ' at ${medicationList[index].hour}:${medicationList[index].minutes > 9 ? medicationList[index].minutes : '0' + (medicationList[index].minutes).toString()}')));
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
                                    'I want give medication to my dog:',
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
                                                            "   Choose Time for first giving   "),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            "Choose Time for second giving"),
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
                                                            "    Choose Time for first giving    "),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            " Choose Time for second giving "),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: _selectTime,
                                                        child: Text(
                                                            "   Choose Time for third giving   "),
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
                          // NotificationWeekAndTime? pickedSchedule =
                          //     await pickSchedule(context);
                          // if (pickedSchedule != null) {
                          //   createBathNotificationEveryMonth(
                          //       pickedSchedule, widget.pet);
                          // }
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
          _addMedication(widget.pet, () {
            setState(() {});
          });
        },
        tooltip: 'Add Medication',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addMedication(Pet pet, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddMedication(pet: pet, callback: callback);
        });
  }

  Future<void> _selectTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      setState(() {
        medicationHourRemined = timeOfDay.hour;
        medicationMinuteRemined = timeOfDay.minute;
      });
    }
    createMedicationNotificationEveryDay(
        medicationHourRemined, medicationMinuteRemined, pet);
  }
}
