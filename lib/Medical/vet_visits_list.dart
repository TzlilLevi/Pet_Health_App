import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/Medical/add_vet_visit.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/vetVisits.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/widgets/vaccinated_check_box.dart';

class VetVisitsList extends StatefulWidget {
  final Pet pet;
  const VetVisitsList({Key? key, required this.pet}) : super(key: key);

  @override
  State<VetVisitsList> createState() => _VetVisitsListState();
}

class _VetVisitsListState extends State<VetVisitsList> {
  late String name;
  late List<VetVistis> vetVisitsList;
  late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late Pet pet;
  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  bool? done;
  var clinicName = '';
  var treatmeantType = '';
  late DateTime vetVisitDate;
  @override
  void initState() {
    name = widget.pet.name;
    vetVisitsList = widget.pet.vetVisits;
    done = false;
    pet = widget.pet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.pet.name),
      ),
      body: Column(
        children: [
          Container(
            child: ListTile(
                leading: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Icon(
                    Icons.sick,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                    text: '   Vet Visits',
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
                itemCount: vetVisitsList.length,
                padding: const EdgeInsets.all(5.0),
                separatorBuilder: (context, index) => Divider(
                      height: 2.0,
                      color: Colors.black87,
                    ),
                itemBuilder: (context, index) {
                  final item = vetVisitsList[index].treatmeantType;
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.white),
                            Text('Edit', style: TextStyle(color: Colors.white)),
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
                                  "Are you sure you want to delete this ver visit?"),
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
                                  title: const Text('Vet Visits'),
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
                                                  return 'Enter the Vet Visit Date';
                                                }
                                              },
                                              onChanged: (text) {
                                                vetVisitDate = text;
                                              }),
                                          VaccinatedCheckBox(
                                              name: 'Given',
                                              value: vetVisitsList[index].done,
                                              onChanged: (text) {
                                                done = text ?? done;
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
                                            repository.updateVaccin(pet, index);
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
                          vetVisitsList.removeAt(index);
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$item deleted')));
                    },
                    child: ListTile(
                        title: Text(
                            item + " at " + vetVisitsList[index].clinicName),
                        subtitle: Text(dateFormat
                                .format(vetVisitsList[index].date) +
                            ' at ${vetVisitsList[index].hour}:${vetVisitsList[index].minutes > 9 ? vetVisitsList[index].minutes : '0' + (vetVisitsList[index].minutes).toString()}'),
                        trailing: vetVisitsList[index].done == true
                            ? Icon(Icons.done)
                            : Icon(Icons.close)),
                  );
                }),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 0, 0, 40),
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
          _addVetVisits(widget.pet, () {
            setState(() {});
          });
        },
        tooltip: 'Add Vet Visit',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addVetVisits(Pet pet, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddVetVisit(pet: pet, callback: callback);
        });
  }
}
