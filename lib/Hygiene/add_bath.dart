import 'package:flutter/material.dart';
import 'package:pet_health_app/models/bath.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/notifications.dart';

class AddBath extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddBath({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddBathState createState() => _AddBathState();
}

class _AddBathState extends State<AddBath> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime bathDate;
  List<String> bathList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int bathHour;
  late int bathMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Bath'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Bath Date';
                        }
                      },
                      onChanged: (text) {
                        bathDate = text;
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
                  final newBath = Bath(
                      date: bathDate, hour: bathHour, minutes: bathMinutes);
                  pet.bathes.add(newBath);
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
        bathHour = timeOfDay.hour;
        bathMinutes = timeOfDay.minute;
      });
    }
  }
}
