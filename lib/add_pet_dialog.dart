import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/notifications.dart';

import 'models/pet.dart';
import 'repository/data_repository.dart';
import 'widgets/choose_chips.dart';
import 'widgets/date_picker.dart';

class AddPetDialog extends StatefulWidget {
  //final Pet pet;
  const AddPetDialog({Key? key}) : super(key: key);

  @override
  _AddPetDialogState createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  String? petName;
  String character = '';
  String characterGender = '';
  String dropdownValue = 'Select type';
  late List<CategoryOption> genderTypes;
  //String type = '';
  String gender = '';
  final DataRepository repository = DataRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late DateTime birthday;
  @override
  void initState() {
    gender = '';
    genderTypes = [
      CategoryOption(type: 'Male', name: 'Male', isSelected: gender == 'Male'),
      CategoryOption(
          type: 'Female', name: 'Female', isSelected: gender == 'Female'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Pet'),
        content: SingleChildScrollView(
            child: ListBody(
          children: <Widget>[
            // ChooseType(
            //   title: 'Gender',
            //   options: genderTypes,
            //   onOptionTap: (value) {
            //     setState(() {
            //       genderTypes.forEach((element) {
            //         gender = value.type;
            //         element.isSelected = element.type == value.type;
            //       });
            //     });
            //   },
            // ),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter a Pet Name'),
              onChanged: (text) => petName = text,
            ),
            // DropdownButton<String>(
            //     value: dropdownValue,
            //     icon: const Icon(Icons.arrow_downward),
            //     elevation: 16,
            //     style: const TextStyle(color: Colors.black87),
            //     underline: Container(
            //       height: 2,
            //       color: Colors.red[700],
            //     ),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         dropdownValue = newValue!;
            //         type = newValue;
            //       });
            //     },
            //     items: <String>['Select type', 'Dog', 'Cat', 'Other']
            //         .map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList()),
            // DropdownButton<String>(
            //     value: dropdownValue,
            //     icon: const Icon(Icons.arrow_downward),
            //     elevation: 16,
            //     style: const TextStyle(color: Colors.black87),
            //     underline: Container(
            //       height: 2,
            //       color: Colors.red[700],
            //     ),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         dropdownValue = newValue!;
            //         gender = newValue;
            //       });
            //     },
            //     items: <String>['Select type', 'Male', 'Female']
            //         .map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList()),
            //Row(
            // children: [
            RadioListTile(
              title: const Text('Male'),
              value: 'Male',
              groupValue: characterGender,
              onChanged: (value) {
                setState(() {
                  characterGender = (value ?? '') as String;
                });
              },
            ),
            RadioListTile(
              title: const Text('Female'),
              value: 'Female',
              groupValue: characterGender,
              onChanged: (value) {
                setState(() {
                  characterGender = (value ?? '') as String;
                });
              },
            ),
            //  ],
            // ),
            DatePicker(
                name: 'Birthday',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the birthday of your pet';
                  }
                },
                onChanged: (text) {
                  birthday = text;
                }),
            // Row(
            //   children: [
            RadioListTile(
              title: const Text('Cat'),
              value: 'cat',
              groupValue: character,
              onChanged: (value) {
                setState(() {
                  character = (value ?? '') as String;
                });
              },
            ),
            RadioListTile(
              title: const Text('Dog'),
              value: 'dog',
              groupValue: character,
              onChanged: (value) {
                setState(() {
                  character = (value ?? '') as String;
                });
              },
            ),
            RadioListTile(
              title: const Text('Other'),
              value: 'other',
              groupValue: character,
              onChanged: (value) {
                setState(() {
                  character = (value ?? '') as String;
                });
              },
            )
          ],
        )
            // ],
            //  ),
            ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () async {
                final User? user = auth.currentUser;

                if (petName != null &&
                    character != null &&
                    characterGender != null &&
                    birthday != null) {
                  final newPet = Pet(petName!,
                      uid: user!.uid,
                      type: character,
                      gender: characterGender,
                      birthday: birthday,
                      vaccinations: [],
                      bathes: [],
                      gallery: [],
                      food: [],
                      teeth: [],
                      weight: [],
                      height: [],
                      vetVisits: [],
                      medications: [],
                      leashesAndCollars: [],
                      beds: [],
                      foodPlate: [],
                      waterFountain: [],
                      toys: [],
                      antiFlea: [],
                      walk: [],
                      hair: [],
                      ears: [],
                      nails: []);
                  repository.addPet(newPet);
                  birthdayNotification(newPet);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add')),
        ]);
  }
}
