import 'package:flutter/material.dart';
import 'package:pet_health_app/models/medication.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';

class AddMedication extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddMedication({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  late DateTime medicationDate;
  late String medicationName = '';
  late String amount;
  List<String> medicationList = <String>[];
  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  late int medicationHour;
  late int medicationMinutes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Medication'),
        content: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: <Widget>[
                  TextFormField(
                    maxLines: 1,
                    onChanged: (medicationName) =>
                        setState(() => this.medicationName = medicationName),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Medication Name',
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
                          return 'Enter the Medication Supply Date';
                        }
                      },
                      onChanged: (date) {
                        medicationDate = date;
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
                  final newMedication = Medication(
                      date: medicationDate,
                      hour: medicationHour,
                      minutes: medicationMinutes,
                      amount: int.parse(this.amount),
                      medicationName: medicationName);
                  pet.medications.add(newMedication);
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
        medicationHour = timeOfDay.hour;
        medicationMinutes = timeOfDay.minute;
      });
    }
  }
}
