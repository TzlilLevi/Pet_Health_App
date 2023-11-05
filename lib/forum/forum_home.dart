import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_health_app/forum/card_posts_forum.dart';
import 'package:pet_health_app/forum/posts_list.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({Key? key}) : super(key: key);

  @override
  State<ForumHome> createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  "assets/icons/ears.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostsList(forumName: 'Dogs')));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Dogs")
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
                                  "assets/icons/cat-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostsList(forumName: 'Cats')));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Cats")
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
                                  "assets/icons/paw-print-svgrepo-com.svg",
                                ),
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostsList(forumName: 'Other')));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text("Other")
                      ],
                    ),
                  ),
                ]),
              ),
            ])));
  }
}
