import 'package:flutter/material.dart';
import 'package:pet_health_app/models/food_plate.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddFoodPlate extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddFoodPlate({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  _AddFoodPlateState createState() => _AddFoodPlateState();
}

class _AddFoodPlateState extends State<AddFoodPlate> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime foodPlateDate;
  List<String> foodPlateList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int foodPlateHour;
  late int foodPlateMinutes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Food Plate'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the food plate Date';
                        }
                      },
                      onChanged: (text) {
                        foodPlateDate = text;
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
                  final newFoodPlate = FoodPlate(
                      date: foodPlateDate,
                      hour: foodPlateHour,
                      minutes: foodPlateMinutes);
                  pet.foodPlate.add(newFoodPlate);
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
        foodPlateHour = timeOfDay.hour;
        foodPlateMinutes = timeOfDay.minute;
      });
    }
  }
}
