import 'package:flutter/material.dart';
import 'package:pet_health_app/models/hair.dart';
import 'package:pet_health_app/models/nails.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddNails extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddNails({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddNailsState createState() => _AddNailsState();
}

class _AddNailsState extends State<AddNails> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime nailsDate;
  List<String> nailsList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int nailsHour;
  late int nailsMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Nails'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Nails Date';
                        }
                      },
                      onChanged: (text) {
                        nailsDate = text;
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
                  final newNails = Nails(
                      date: nailsDate, hour: nailsHour, minutes: nailsMinutes);
                  pet.nails.add(newNails);
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
        nailsHour = timeOfDay.hour;
        nailsMinutes = timeOfDay.minute;
      });
    }
  }
}
