import 'package:flutter/material.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/water_fountain.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddWater extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddWater({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddWaterState createState() => _AddWaterState();
}

class _AddWaterState extends State<AddWater> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime waterDate;
  List<String> waterList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int waterHour;
  late int waterMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Water Fountain'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Water Fountain Date';
                        }
                      },
                      onChanged: (text) {
                        waterDate = text;
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
                  final newWater = WaterFountain(
                      date: waterDate, hour: waterHour, minutes: waterMinutes);
                  pet.waterFountain.add(newWater);
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
        waterHour = timeOfDay.hour;
        waterMinutes = timeOfDay.minute;
      });
    }
  }
}
