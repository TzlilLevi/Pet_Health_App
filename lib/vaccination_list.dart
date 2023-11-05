import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/add_vaccination.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/vaccination_details.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/widgets/vaccinated_check_box.dart';
import 'models/vaccination.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:listview_utils/listview_utils.dart';
//import 'package:flutter_icons/flutter_icons.dart';

class VaccinationList extends StatefulWidget {
  final Pet pet;
  //final Widget Function(Vaccination) buildRow;
  const VaccinationList({Key? key, required this.pet}) : super(key: key);

  @override
  _VaccinationListState createState() => _VaccinationListState();
}

class _VaccinationListState extends State<VaccinationList> {
  late String name;
  late List<Vaccination> vaccinstionsList;
  late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late Pet pet;

  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  bool? done;
  var vaccination = '';
  late DateTime vaccinationDate;
  @override
  void initState() {
    name = widget.pet.name;
    vaccinstionsList = widget.pet.vaccinations;
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
                    FontAwesomeIcons.syringe,
                    color: Colors.blueAccent,
                  ),
                ),
                TextSpan(
                    text: '   Vaccinctions',
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
                itemCount: vaccinstionsList.length,
                padding: const EdgeInsets.all(5.0),
                separatorBuilder: (context, index) => Divider(
                      height: 2.0,
                      color: Colors.black87,
                    ),
                itemBuilder: (context, index) {
                  final item = vaccinstionsList[index].vaccination;
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
                                  "Are you sure you want to delete this vaccination?"),
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
                                  title: const Text('Vaccination'),
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
                                                vaccinationDate = text;
                                              }),
                                          VaccinatedCheckBox(
                                              name: 'Given',
                                              value:
                                                  vaccinstionsList[index].done,
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
                          vaccinstionsList.removeAt(index);
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$item deleted')));
                    },
                    child: ListTile(
                        title: Text(item),
                        subtitle: Text(dateFormat
                                .format(vaccinstionsList[index].date) +
                            ' at ${vaccinstionsList[index].hour}:${vaccinstionsList[index].minutes > 9 ? vaccinstionsList[index].minutes : '0' + (vaccinstionsList[index].minutes).toString()}'),
                        trailing: vaccinstionsList[index].done == true
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
          _addVaccination(widget.pet, () {
            setState(() {});
          });
        },
        tooltip: 'Add Vaccination',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addVaccination(Pet pet, Function callback) {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return AddVaccination(pet: pet, callback: callback);
        });
  }

  Widget buildRow(Vaccination vaccination) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(vaccination.vaccination),
        ),
        Text(dateFormat.format(vaccination.date)),
        Checkbox(
          value: vaccination.done,
          onChanged: (bool? newValue) {
            setState(() {
              vaccination.done = newValue;
            });
          },
        )
      ],
    );
  }
}
