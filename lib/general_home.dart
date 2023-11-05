import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_health_app/general/measurements_bottom_bar.dart';
import 'package:pet_health_app/general/walk_list.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/upload_and_download_docs/docs_bottom_bar.dart';

class GeneralHome extends StatefulWidget {
  final Pet pet;
  const GeneralHome({Key? key, required this.pet}) : super(key: key);

  @override
  _GeneralHomeState createState() => _GeneralHomeState();
}

class _GeneralHomeState extends State<GeneralHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("General"),
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
                                  "assets/icons/dog-walker-person-walk-pet-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WalkList(pet: widget.pet)));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Walk")
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
                                  "assets/icons/docs-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DocsBottomBar(
                                              pet: widget.pet,
                                              subject: "Archive")));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Docs Archive",
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
                                  "assets/icons/pet-weight-weigh-a-pet-small-pet-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MeasurementsBottomBar(
                                                pet: widget.pet,
                                              )));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Measurements",
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
