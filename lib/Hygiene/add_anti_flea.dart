import 'package:flutter/material.dart';
import 'package:pet_health_app/models/anti_flea.dart';
import 'package:pet_health_app/models/hair.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddAntiFlea extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddAntiFlea({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddAntiFleaState createState() => _AddAntiFleaState();
}

class _AddAntiFleaState extends State<AddAntiFlea> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime antiFleaDate;
  List<String> antiFleaList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int antiFleaHour;
  late int antiFleaMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Anti Flea'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Anti Flea Date';
                        }
                      },
                      onChanged: (text) {
                        antiFleaDate = text;
                      }),
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: Text("Choose Time"),
                  ),
                ]))),
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
                  final newAntiFlea = AntiFlea(
                      date: antiFleaDate,
                      hour: antiFleaHour,
                      minutes: antiFleaMinutes);
                  pet.antiFlea.add(newAntiFlea);
                  repository.updatePet(widget.pet);
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
        antiFleaHour = timeOfDay.hour;
        antiFleaMinutes = timeOfDay.minute;
      });
    }
  }
}
