import 'package:flutter/material.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/walk.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddWalk extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddWalk({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddWalkState createState() => _AddWalkState();
}

class _AddWalkState extends State<AddWalk> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime walkDate;
  List<String> walkList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int walkHour;
  late int walkMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Walk'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Walk Date';
                        }
                      },
                      onChanged: (text) {
                        walkDate = text;
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
                  final newWalk = Walk(
                      date: walkDate, hour: walkHour, minutes: walkMinutes);
                  pet.walk.add(newWalk);
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
        walkHour = timeOfDay.hour;
        walkMinutes = timeOfDay.minute;
      });
    }
  }
}
