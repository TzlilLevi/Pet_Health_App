import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_health_app/Medical/medications_list.dart';
import 'package:pet_health_app/Medical/vet_visits_list.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/upload_and_download_docs/docs_bottom_bar.dart';

class MedicalHome extends StatefulWidget {
  final Pet pet;
  const MedicalHome({Key? key, required this.pet}) : super(key: key);

  @override
  _MedicalHomeState createState() => _MedicalHomeState();
}

class _MedicalHomeState extends State<MedicalHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Medical"),
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
                                  "assets/icons/veterinarian-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  print("I am here");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VetVisitsList(
                                                pet: widget.pet,
                                              )));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Vet Visits",
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
                                  "assets/icons/medical-records-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DocsBottomBar(
                                              pet: widget.pet,
                                              subject: "Medical")));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Medical Docs",
                          style: TextStyle(fontSize: 11),
                        )
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
                                  "assets/icons/tablet-and-capsule-medications-svgrepo-com.svg",
                                  color: Colors.black,
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MedicationList(
                                                pet: widget.pet,
                                              )));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Medications",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ])));
  }
}
