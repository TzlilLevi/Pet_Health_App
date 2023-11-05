import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/Hygiene/add_anti_flea.dart';
import 'package:pet_health_app/models/anti_flea.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/utilities.dart';

class AntiFleaList extends StatefulWidget {
  final Pet pet;
  const AntiFleaList({Key? key, required this.pet}) : super(key: key);

  @override
  _AntiFleaListState createState() => _AntiFleaListState();
}

class _AntiFleaListState extends State<AntiFleaList> {
  late List<AntiFlea> antiFleaList;
  late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late Pet pet;
  late DateTime antiFleaDate;
  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  void initState() {
    pet = widget.pet;
    antiFleaList = widget.pet.antiFlea;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Anti Flea"),
      ),
      body: Column(
        children: [
          Container(
            child: ListTile(
                leading: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Icon(
                    FontAwesomeIcons.bug,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                    text: '   Anti Flea',
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
                itemCount: antiFleaList.length,
                padding: const EdgeInsets.all(5.0),
                separatorBuilder: (context, index) => Divider(
                      height: 2.0,
                      color: Colors.black87,
                    ),
                itemBuilder: (context, index) {
                  final item = antiFleaList[index].date;
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
                                    "Are you sure you want to delete this anti flea?"),
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
                                    title: const Text('Anti Flea'),
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
                                                  antiFleaDate = text;
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
                            antiFleaList.removeAt(index);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item deleted')));
                      },
                      child: ListTile(
                          title: Text(dateFormat.format(item)),
                          subtitle: Text(dateFormat
                                  .format(antiFleaList[index].date) +
                              ' at ${antiFleaList[index].hour}:${antiFleaList[index].minutes > 9 ? antiFleaList[index].minutes : '0' + (antiFleaList[index].minutes).toString()}')));
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
                          NotificationWeekAndTime? pickedSchedule =
                              await pickSchedule(context);
                          if (pickedSchedule != null) {
                            createHygieneNotification(
                                pickedSchedule, widget.pet, "Anti Flea");
                          }
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
          _addAntiFlea(widget.pet, () {
            setState(() {});
          });
        },
        tooltip: 'Add Anti Flea',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addAntiFlea(Pet pet, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddAntiFlea(pet: pet, callback: callback);
        });
  }
}
