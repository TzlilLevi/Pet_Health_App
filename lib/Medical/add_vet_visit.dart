import 'package:flutter/material.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/vetVisits.dart';
import 'package:pet_health_app/notifications.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/widgets/vaccinated_check_box.dart';

class AddVetVisit extends StatefulWidget {
  final Pet pet;
  final Function callback;
  const AddVetVisit({Key? key, required this.pet, required this.callback})
      : super(key: key);

  @override
  State<AddVetVisit> createState() => _AddVetVisitState();
}

class _AddVetVisitState extends State<AddVetVisit> {
  final _formKey = GlobalKey<FormState>();
  late Pet pet;
  final DataRepository repository = DataRepository();
  var done = false;
  var clinicName = '';
  var treatmeantType = '';
  late DateTime vetVisitDate;

  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  @override
  late int vetVisitHour;
  late int vetVisitMinutes;
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Vet Visit'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                TextFormField(
                  maxLines: 1,
                  onChanged: (clinicName) =>
                      setState(() => this.clinicName = clinicName),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Clinic Name',
                  ),
                ),
                TextFormField(
                  maxLines: 1,
                  initialValue: '',
                  onChanged: (treatmeantType) =>
                      setState(() => this.treatmeantType = treatmeantType),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Treatmeant Type',
                  ),
                ),
                DatePicker(
                    name: 'Date',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Vet Visit Date';
                      }
                    },
                    onChanged: (text) {
                      vetVisitDate = text;
                    }),
                ElevatedButton(
                  onPressed: _selectTime,
                  child: Text("Choose Time"),
                ),
                VaccinatedCheckBox(
                    name: 'Done',
                    value: done,
                    onChanged: (text) {
                      done = text ?? done;
                    }),
              ],
            ),
          ),
        ),
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
                  final newVetVisit = VetVistis(
                      clinicName: clinicName,
                      treatmeantType: treatmeantType,
                      date: vetVisitDate,
                      hour: vetVisitHour,
                      minutes: vetVisitMinutes,
                      done: done);
                  pet.vetVisits.add(newVetVisit);
                  repository.updatePet(widget.pet);
                  createVetVisitNotification(newVetVisit, pet);
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
        vetVisitHour = timeOfDay.hour;
        vetVisitMinutes = timeOfDay.minute;
      });
    }
  }
}
