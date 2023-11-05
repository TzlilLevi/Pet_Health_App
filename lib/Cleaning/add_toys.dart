import 'package:flutter/material.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/toys.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddToys extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddToys({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddToysState createState() => _AddToysState();
}

class _AddToysState extends State<AddToys> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime toysDate;
  List<String> toysList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int toysHour;
  late int toysMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Toys'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Toy Date';
                        }
                      },
                      onChanged: (text) {
                        toysDate = text;
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
                  final newToy = Toys(
                      date: toysDate, hour: toysHour, minutes: toysMinutes);
                  pet.toys.add(newToy);
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
        toysHour = timeOfDay.hour;
        toysMinutes = timeOfDay.minute;
      });
    }
  }
}
