import 'package:flutter/material.dart';
import 'package:pet_health_app/pet_profile.dart';
import 'package:pet_health_app/professionals.dart';
import 'package:pet_health_app/screens/pet_home/pet_home.dart';

import 'models/pet.dart';
import 'pet_details.dart';

class PetRoom extends StatelessWidget {
  final Pet pet;

  const PetRoom({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text(pet.name + " profile"),
          //   actions: <Widget>[
          //     new IconButton(
          //       icon: new Icon(Icons.edit),
          //       highlightColor: Colors.pink,
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => PetDetail(pet: pet)));
          //       },
          //     ),
          //   ],
          //   leading: IconButton(
          //       icon: const Icon(Icons.arrow_back),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       }),
          // ),
          body: //PetDetail(pet: pet),
              PetHome(pet: pet)),
    );
  }
}
