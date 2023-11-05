import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_health_app/Hygiene/anti_flea_list.dart';
import 'package:pet_health_app/Hygiene/ears_list.dart';
import 'package:pet_health_app/Hygiene/hair_list.dart';
import 'package:pet_health_app/Hygiene/nails_list.dart';
import 'package:pet_health_app/Hygiene/teeth_list.dart';
import 'package:pet_health_app/models/pet.dart';
import 'Hygiene/bath_list.dart';

class HygieneHome extends StatefulWidget {
  final Pet pet;
  const HygieneHome({Key? key, required this.pet}) : super(key: key);

  @override
  _HygieneHomeState createState() => _HygieneHomeState();
}

class _HygieneHomeState extends State<HygieneHome> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Hygiene"),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 55.0),
            alignment: Alignment.center,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.white,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3, color: Colors.blue)),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/bath.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  print("I am here");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BathList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Bath")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.white,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3, color: Colors.blue)),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/scissors-cutting-hair-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HairList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Hair")
                      ],
                    ),
                  ),

                  // IconButton(
                  //     icon: Image.asset('assets/images/food.png'),
                  //     iconSize: 76,
                  //     onPressed: () {}),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.white,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3, color: Colors.blue)),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/ears.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EarsList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Ears")
                      ],
                    ),
                  ),
                ]),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.white,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3, color: Colors.blue)),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/nails.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NailsList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Nails")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.white,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3, color: Colors.blue)),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/teeth.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TeethList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Teeth")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.white,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3, color: Colors.blue)),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/icons/flea.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AntiFleaList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Anti-flea")
                      ],
                    ),
                  ),
                ],
              )
            ])));
  }
}
