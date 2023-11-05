import 'package:flutter/material.dart';
import 'package:pet_health_app/models/leash_and_collar.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/notifications.dart';

class AddLeashAndCollar extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddLeashAndCollar({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddLeashAndCollarState createState() => _AddLeashAndCollarState();
}

class _AddLeashAndCollarState extends State<AddLeashAndCollar> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime leashAndCollarDate;
  List<String> leashAndCollarList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int leashAndCollarHour;
  late int leashAndCollarMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Leash And Collar'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Leash And Collar Date';
                        }
                      },
                      onChanged: (text) {
                        leashAndCollarDate = text;
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
                  final newLeashAndCollar = LeashAndCollar(
                      date: leashAndCollarDate,
                      hour: leashAndCollarHour,
                      minutes: leashAndCollarMinutes);
                  pet.leashesAndCollars.add(newLeashAndCollar);
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
        leashAndCollarHour = timeOfDay.hour;
        leashAndCollarMinutes = timeOfDay.minute;
      });
    }
  }
}
