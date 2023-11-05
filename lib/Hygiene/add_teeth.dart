import 'package:flutter/material.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/teeth.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddTeeth extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddTeeth({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  State<AddTeeth> createState() => _AddTeethState();
}

class _AddTeethState extends State<AddTeeth> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime teethDate;
  List<String> teethList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int teethHour;
  late int teethMinutes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Teeth'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Brush Teeth Date';
                        }
                      },
                      onChanged: (text) {
                        teethDate = text;
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
                  final newTeeth = Teeth(
                      date: teethDate, hour: teethHour, minutes: teethMinutes);
                  pet.teeth.add(newTeeth);
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
        teethHour = timeOfDay.hour;
        teethMinutes = timeOfDay.minute;
      });
    }
  }
}
