import 'package:flutter/material.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';

import 'models/pet.dart';
import 'widgets/text_field.dart';
import 'models/vaccination.dart';
import 'widgets/date_picker.dart';
import 'widgets/vaccinated_check_box.dart';

class AddVaccination extends StatefulWidget {
  final Pet pet;
  final Function callback;

  const AddVaccination({Key? key, required this.pet, required this.callback})
      : super(key: key);
  @override
  _AddVaccinationState createState() => _AddVaccinationState();
}

class _AddVaccinationState extends State<AddVaccination> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  var done = false;
  var vaccination = '';
  late DateTime vaccinationDate;
  late int vaccinationHour;
  late int year;
  late int numOfWeeks;
  late int numOfMonths;
  String dropdownValue = 'Select Vaccin';
  List<String> vaccinList = <String>[];
  @override
  void initState() {
    year = (DateTime.now().year - widget.pet.birthday.year);
    numOfWeeks = (DateTime.now().month - widget.pet.birthday.month) * 4;
    numOfMonths = (DateTime.now().month - widget.pet.birthday.month);
    pet = widget.pet;
    super.initState();
  }

  List<DropdownMenuItem<String>> vaccinSuitToPetType() {
    if (pet.type == 'dog') {
      if (year < 1) {
        if (numOfWeeks < 6) {
          return <String>[
            'Select Vaccin',
            'No Vaccin in this age',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        } else if (numOfWeeks >= 6 && numOfWeeks <= 8) {
          return <String>[
            'Select Vaccin',
            'Distemper',
            'Parvovirus',
            'Bordetella',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        } else if (numOfWeeks >= 10 && numOfWeeks <= 12) {
          return <String>[
            'Select Vaccin',
            'Distemper',
            'Adenovirus',
            'Parainfluenza',
            'Parvovirus',
            'Influenza',
            'Leptospirosis',
            'Bordetella',
            'Lyme disease',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        } else if (numOfWeeks >= 16 && numOfWeeks <= 18) {
          return <String>[
            'Select Vaccin',
            'Distemper',
            'Adenovirus',
            'Parainfluenza',
            'Parvovirus',
            'Rabies',
            'Influenza',
            'Leptospirosis',
            'Bordetella',
            'Lyme disease',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        }
      } else {
        if (numOfMonths >= 12 && numOfMonths <= 16) {
          return <String>[
            'Select Vaccin',
            'Distemper',
            'Adenovirus',
            'Parainfluenza',
            'Parvovirus',
            'Rabies',
            'Coronavirus',
            'Leptospirosis',
            'Bordetella',
            'Lyme disease',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        } else if (year >= 1 && year <= 2) {
          return <String>[
            'Select Vaccin',
            'Distemper',
            'Adenovirus',
            'Parainfluenza',
            'Parvovirus',
            'Influenza',
            'Coronavirus',
            'Leptospirosis',
            'Bordetella',
            'Lyme disease',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        } else if (year >= 3) {
          return <String>[
            'Select Vaccin',
            'Rabies',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();
        }
      }
    } else if (pet.type == 'cat') {
      return <String>[
        'Select Vaccin',
        'FVRCP',
        'Bordetella',
        'Calicivirus',
        'Chlamydophila feils',
        'FIR',
        'Feiline infrctious Peritonitis',
        'FeLV',
        'FVR',
        'Giardia',
        'Panleukopenia',
        'Rabies'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList();
    }
    return <String>['Select Vaccin']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  late int vaccinHour;
  late int vaccinMinutes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Vaccination'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black87),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        vaccination = newValue;
                      });
                    },
                    items: vaccinSuitToPetType()),
                DatePicker(
                    name: 'Date',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Vaccination Date';
                      }
                    },
                    onChanged: (text) {
                      vaccinationDate = text;
                    }),
                ElevatedButton(
                  onPressed: _selectTime,
                  child: Text("Choose Time"),
                ),
                VaccinatedCheckBox(
                    name: 'Given',
                    value: done,
                    onChanged: (text) {
                      done = text ?? done;
                    }),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          // TextButton(
          //   onPressed:
          //   child: const Text('Remined me!'),
          // ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop();
                  final newVaccination = Vaccination(vaccination,
                      date: vaccinationDate,
                      hour: vaccinHour,
                      minutes: vaccinMinutes,
                      done: done);
                  pet.vaccinations.add(newVaccination);
                  repository.updatePet(widget.pet);
                  createVaccinationNotification(newVaccination, pet);
                }
                widget.callback();
              },
              child: const Text('Add')),
        ]);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      setState(() {
        vaccinHour = timeOfDay.hour;
        vaccinMinutes = timeOfDay.minute;
      });
    }
  }
}
