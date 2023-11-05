import 'package:flutter/material.dart';
import 'package:pet_health_app/models/bed.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddBed extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddBed({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddBedState createState() => _AddBedState();
}

class _AddBedState extends State<AddBed> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime bedDate;
  List<String> bedList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int bedHour;
  late int bedMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Bed'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Bed Date';
                        }
                      },
                      onChanged: (text) {
                        bedDate = text;
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
                  final newBed = Bed(
                      date: bedDate, hour: bedHour, minutes: bedMinutes);
                  pet.beds.add(newBed);
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
        bedHour = timeOfDay.hour;
        bedMinutes = timeOfDay.minute;
      });
    }
  }
}
