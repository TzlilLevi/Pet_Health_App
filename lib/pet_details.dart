import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'models/pet.dart';
import 'add_vaccination.dart';
import 'vaccination_list.dart';
import 'widgets/date_picker.dart';
import 'widgets/text_field.dart';
import 'models/vaccination.dart';
import 'widgets/choose_chips.dart';
import 'repository/data_repository.dart';

class PetDetail extends StatefulWidget {
  final Pet pet;

  const PetDetail({Key? key, required this.pet}) : super(key: key);

  @override
  _PetDetailState createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {
  final DataRepository repository = DataRepository();
  final _formKey = GlobalKey<FormState>();
  //final dateFormat = DateFormat('yyyy-MM-dd');
  late List<CategoryOption> animalTypes;
  late List<CategoryOption> genderTypes;
  late String name;
  late String type;
  late String gender;
  String? profileImage;
  //String? birthday;
  String? notes;
  late File _pickedImage;
  late DateTime birthday;
  @override
  void initState() {
    type = widget.pet.type;
    name = widget.pet.name;
    profileImage = widget.pet.profileImage;
    genderTypes = [
      CategoryOption(type: 'Male', name: 'Male', isSelected: type == 'Male'),
      CategoryOption(
          type: 'Female', name: 'Female', isSelected: type == 'Female'),
    ];
    birthday = widget.pet.birthday;
    animalTypes = [
      CategoryOption(type: 'cat', name: 'Cat', isSelected: type == 'cat'),
      CategoryOption(type: 'dog', name: 'Dog', isSelected: type == 'dog'),
      CategoryOption(type: 'other', name: 'Other', isSelected: type == 'other'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      height: double.infinity,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  profileImage ??
                      'https://www.creativefabrica.com/wp-content/uploads/2020/09/01/Dog-paw-vector-icon-logo-design-heart-Graphics-5223218-1-1-580x387.jpg',
                ),
                radius: 70.0,
                // child: Align(
                //     alignment: Alignment.bottomRight,
                //     child: new IconButton(
                //       icon: new Icon(Icons.add_a_photo),
                //       color: Colors.black,
                //       highlightColor: Colors.pink,
                //       onPressed: () {
                //         //_showPickOptionsDialog(context);
                //       },
                //     )),
              ),
              UserTextField(
                name: 'Pet Name',
                initialValue: widget.pet.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input name';
                  }
                },
                inputType: TextInputType.name,
                onChanged: (value) => name = value ?? name,
              ),
              // UserTextField(
              //   name: 'Pet Image',
              //   initialValue: widget.pet.profileImage ?? '',
              //   validator: (value) {},
              //   inputType: TextInputType.name,
              //   onChanged: (value) => profileImage = value,
              // ),
              // UserTextField(
              //   name: 'Pet Birthday',
              //   initialValue: widget.pet.birthday ?? '',
              //   validator: (value) {},
              //   inputType: TextInputType.name,
              //   onChanged: (value) => birthday = value,
              // ),
              DatePicker(
                  name: 'Date',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the birthday of your pet';
                    }
                  },
                  onChanged: (text) {
                    birthday = text;
                  }),
              ChooseType(
                title: 'Animal Type',
                options: animalTypes,
                onOptionTap: (value) {
                  setState(() {
                    animalTypes.forEach((element) {
                      type = value.type;
                      element.isSelected = element.type == value.type;
                    });
                  });
                },
              ),
              ChooseType(
                title: 'Gender',
                options: genderTypes,
                onOptionTap: (value) {
                  setState(() {
                    genderTypes.forEach((element) {
                      type = value.type;
                      element.isSelected = element.type == value.type;
                    });
                  });
                },
              ),
              const SizedBox(height: 20.0),
              // UserTextField(
              //   name: 'notes',
              //   initialValue: widget.pet.notes ?? '',
              //   validator: (value) {},
              //   inputType: TextInputType.text,
              //   onChanged: (value) => notes = value,
              // ),
              // VaccinationList(pet: widget.pet, buildRow: buildRow),
              // FloatingActionButton(
              //   onPressed: () {
              //     _addVaccination(widget.pet, () {
              //       setState(() {});
              //     });
              //   },
              //   tooltip: 'Add Vaccination',
              //   child: const Icon(Icons.add),
              // ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.blue.shade600,
                      onPressed: () {
                        Navigator.of(context).pop();
                        repository.deletePet(widget.pet);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )),
                  MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).pop();
                        widget.pet.name = name;
                        widget.pet.type = type;
                        widget.pet.notes = notes ?? widget.pet.notes;
                        widget.pet.birthday = birthday;
                        //widget.pet.profileImage =
                        //profileImage ?? widget.pet.profileImage;
                        repository.updatePet(widget.pet);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // Widget buildRow(Vaccination vaccination) {
  //   return Row(
  //     children: <Widget>[
  //       Expanded(
  //         flex: 1,
  //         child: Text(vaccination.vaccination),
  //       ),
  //       Text(dateFormat.format(vaccination.date)),
  //       Checkbox(
  //         value: vaccination.done ?? false,
  //         onChanged: (newValue) {
  //           setState(() {
  //             vaccination.done = newValue;
  //           });
  //         },
  //       )
  //     ],
  //   );
  // }

  // void _addVaccination(Pet pet, Function callback) {
  //   showDialog<Widget>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AddVaccination(pet: pet, callback: callback);
  //       });
  // }
}
