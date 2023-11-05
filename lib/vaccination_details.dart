import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/vaccination.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/widgets/date_picker.dart';
import 'package:pet_health_app/widgets/vaccinated_check_box.dart';

class VaccinationDetails extends StatefulWidget {
  final Vaccination vaccination;
  final Pet pet;
  const VaccinationDetails(
      {Key? key, required this.vaccination, required this.pet})
      : super(key: key);

  @override
  _VaccinationDetailsState createState() => _VaccinationDetailsState();
}

class _VaccinationDetailsState extends State<VaccinationDetails> {
  final DataRepository repository = DataRepository();
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  late DateTime vaccinationDate;
  var done;

  void initState() {
    done = widget.vaccination.done;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            height: double.infinity,
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  const SizedBox(height: 20.0),
                  DatePicker(
                      name: 'Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the vaccin date';
                        }
                      },
                      onChanged: (text) {
                        vaccinationDate = text;
                      }),
                  VaccinatedCheckBox(
                      name: 'Given',
                      value: done,
                      onChanged: (text) {
                        done = text ?? done;
                      }),
                ])))));
  }
}
