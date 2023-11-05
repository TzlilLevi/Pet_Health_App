import 'package:flutter/material.dart';
import 'package:pet_health_app/models/height.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/weight.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddStaticsheight extends StatefulWidget {
  final Pet pet;
  const AddStaticsheight({Key? key, required this.pet}) : super(key: key);

  @override
  State<AddStaticsheight> createState() => _AddStaticsheightState();
}

class _AddStaticsheightState extends State<AddStaticsheight> {
  final _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  late DateTime subjectDate;
  late String height;
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
              'Add Height',
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

  void addHeight() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final height = Height(
        date: subjectDate,
        height: double.parse(this.height),
      );
      widget.pet.height?.add(height);
      repository.updatePet(widget.pet);
      Navigator.of(context).pop();
    }
  }

  Widget buildDate() => DatePicker(
      name: 'Date',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the date you measure your pet height';
        }
      },
      onChanged: (date) {
        subjectDate = date;
      });

  Widget buildWeight() => TextFormField(
        maxLines: 1,
        initialValue: '',
        onChanged: (height) => setState(() => this.height = height),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Height',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          onPressed: addHeight,
          child: Text('Save'),
        ),
      );
}
