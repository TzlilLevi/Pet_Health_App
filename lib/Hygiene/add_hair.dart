import 'package:flutter/material.dart';
import 'package:pet_health_app/models/hair.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddHair extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddHair({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddHairState createState() => _AddHairState();
}

class _AddHairState extends State<AddHair> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime hairDate;
  List<String> hairList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int hairHour;
  late int hairMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Hair'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Hair Date';
                        }
                      },
                      onChanged: (text) {
                        hairDate = text;
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
                  final newHair = Hair(
                      date: hairDate, hour: hairHour, minutes: hairMinutes);
                  pet.hair.add(newHair);
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
        hairHour = timeOfDay.hour;
        hairMinutes = timeOfDay.minute;
      });
    }
  }
}
