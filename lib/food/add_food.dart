import 'package:flutter/material.dart';
import 'package:pet_health_app/models/food.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddFood extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddFood({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime foodDate;
  late String foodName = '';
  late String amount;
  List<String> foodList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int foodHour;
  late int foodMinutes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Food'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  TextFormField(
                    maxLines: 1,
                    onChanged: (foodName) =>
                        setState(() => this.foodName = foodName),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Food Name',
                    ),
                  ),
                  TextFormField(
                    maxLines: 1,
                    initialValue: '',
                    onChanged: (amount) => setState(() => this.amount = amount),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Amount',
                    ),
                  ),
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Food Supply Date';
                        }
                      },
                      onChanged: (date) {
                        foodDate = date;
                      }),
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: Text("Choose Time"),
                  ),
                ]))),
        actions: <Widget>[
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
                  final newFood = Food(
                      date: foodDate,
                      hour: foodHour,
                      minutes: foodMinutes,
                      amount: int.parse(this.amount),
                      foodName: foodName);
                  pet.food.add(newFood);
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
        foodHour = timeOfDay.hour;
        foodMinutes = timeOfDay.minute;
      });
    }
  }
}
