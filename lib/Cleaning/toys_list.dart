import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/Cleaning/add_toys.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/models/toys.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/utilities.dart';

class ToysList extends StatefulWidget {
  final Pet pet;
  const ToysList({Key? key, required this.pet}) : super(key: key);

  @override
  _ToysListState createState() => _ToysListState();
}

class _ToysListState extends State<ToysList> {
  late List<Toys> toysList;
  late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late Pet pet;
  late DateTime toysDate;
  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  void initState() {
    pet = widget.pet;
    toysList = widget.pet.toys;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Toys"),
      ),
      body: Column(
        children: [
          Container(
            child: ListTile(
                leading: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Icon(
                    Icons.toys,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                    text: '   Toys',
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
                itemCount: toysList.length,
                padding: const EdgeInsets.all(5.0),
                separatorBuilder: (context, index) => Divider(
                      height: 2.0,
                      color: Colors.black87,
                    ),
                itemBuilder: (context, index) {
                  final item = toysList[index].date;
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
                                    "Are you sure you want to delete this toy?"),
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
                                    title: const Text('Toy'),
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
                                                  toysDate = text;
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
                            toysList.removeAt(index);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item deleted')));
                      },
                      child: ListTile(
                          title: Text(dateFormat.format(item)),
                          subtitle: Text(dateFormat
                                  .format(toysList[index].date) +
                              ' at ${toysList[index].hour}:${toysList[index].minutes > 9 ? toysList[index].minutes : '0' + (toysList[index].minutes).toString()}')));
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
                            createCleanNotification(
                                pickedSchedule, widget.pet, "Toys");
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 5, 30),
              //   child: Center(
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         const SizedBox(height: 30),
              //         ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //               textStyle: const TextStyle(fontSize: 20)),
              //           onPressed: () {
              //             //createBathNotificationEveryMonth(widget.pet);
              //           },
              //           child: const Text('Remined'),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
          _addToy(widget.pet, () {
            setState(() {});
          });
        },
        tooltip: 'Add Toy',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addToy(Pet pet, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddToys(pet: pet, callback: callback);
        });
  }
}
