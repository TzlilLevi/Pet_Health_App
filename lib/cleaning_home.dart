import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_health_app/Cleaning/bed_list.dart';
import 'package:pet_health_app/Cleaning/food_plate_list.dart';
import 'package:pet_health_app/Cleaning/leash_and_collar_list.dart';
import 'package:pet_health_app/Cleaning/toys_list.dart';
import 'package:pet_health_app/Cleaning/water_list.dart';
import 'package:pet_health_app/models/pet.dart';

class CleaningHome extends StatefulWidget {
  final Pet pet;
  const CleaningHome({Key? key, required this.pet}) : super(key: key);

  @override
  _CleaningHomeState createState() => _CleaningHomeState();
}

class _CleaningHomeState extends State<CleaningHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Cleaning"),
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
                                  "assets/icons/collars-collar-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LeashAndCollarList(
                                                  pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Leash & Collar",
                          style: TextStyle(fontSize: 11),
                        )
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
                                  "assets/icons/pet-toy-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ToysList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Toys")
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
                                  "assets/icons/bed.svg",
                                  color: Colors.black,
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BedList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Bed")
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
                                  "assets/icons/bowl-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WaterList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Water Fountain",
                          style: TextStyle(fontSize: 11),
                        )
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
                                  "assets/icons/dog-food-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FoodPlateList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Food Plate",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  //   child: Column(
                  //     children: [
                  //       Material(
                  //         color: Colors.white,
                  //         child: Center(
                  //           child: Ink(
                  //             decoration: const ShapeDecoration(
                  //               color: Colors.white,
                  //               shape: CircleBorder(
                  //                   side: BorderSide(
                  //                       width: 3, color: Colors.blue)),
                  //             ),
                  //             child: IconButton(
                  //               icon: SvgPicture.asset(
                  //                 "assets/icons/flea.svg",
                  //               ),
                  //               iconSize: 50,
                  //               color: Colors.white,
                  //               onPressed: () {},
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Text("Anti-flea")
                  //     ],
                  //   ),
                  // ),
                ],
              )
            ])));
  }
}
