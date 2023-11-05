import 'package:flutter/material.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/weight.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddStaticsWeight extends StatefulWidget {
  final Pet pet;
  const AddStaticsWeight({Key? key, required this.pet}) : super(key: key);

  @override
  State<AddStaticsWeight> createState() => _AddStaticsWeightState();
}

class _AddStaticsWeightState extends State<AddStaticsWeight> {
  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  late DateTime subjectDate;
  late String weight;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Weight',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildDate(),
                  SizedBox(
                    height: 8,
                  ),
                  buildWeight(),
                  SizedBox(
                    height: 32,
                  ),
                  buildButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addWeight() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final weight = Weight(
        date: subjectDate,
        weight: double.parse(this.weight),
      );
      widget.pet.weight?.add(weight);
      repository.updatePet(widget.pet);
      Navigator.of(context).pop();
    }
  }

  Widget buildDate() => DatePicker(
      name: 'Date',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the date you weighed your pet';
        }
      },
      onChanged: (date) {
        subjectDate = date;
      });

  Widget buildWeight() => TextFormField(
        maxLines: 1,
        initialValue: '',
        onChanged: (weight) => setState(() => this.weight = weight),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Weight',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          onPressed: addWeight,
          child: Text('Save'),
        ),
      );
}
