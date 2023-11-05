import 'package:flutter/material.dart';
import 'package:pet_health_app/models/ears.dart';
import 'package:pet_health_app/models/hair.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddEars extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddEars({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddEarsState createState() => _AddEarsState();
}

class _AddEarsState extends State<AddEars> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime earsDate;
  List<String> earsList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int earsHour;
  late int earsMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Ears'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Ears Date';
                        }
                      },
                      onChanged: (text) {
                        earsDate = text;
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
                  final newEars = Ears(
                      date: earsDate, hour: earsHour, minutes: earsMinutes);
                  pet.ears.add(newEars);
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
        earsHour = timeOfDay.hour;
        earsMinutes = timeOfDay.minute;
      });
    }
  }
}
