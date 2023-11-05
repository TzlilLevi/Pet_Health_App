import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/general/statics_height.dart';
import 'package:pet_health_app/general/statics_weight.dart';
import 'package:pet_health_app/models/pet.dart';

class MeasurementsBottomBar extends StatefulWidget {
  final Pet pet;
  const MeasurementsBottomBar({Key? key, required this.pet}) : super(key: key);

  @override
  State<MeasurementsBottomBar> createState() => _MeasurementsBottomBarState();
}

class _MeasurementsBottomBarState extends State<MeasurementsBottomBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      StaticsWeight(
        pet: widget.pet,
        subject: "weight",
      ),
      StaticsHeight(
        pet: widget.pet,
        subject: "height",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Measurements"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.weight, size: 19),
            label: 'Weight',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.height),
            label: 'Height',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(
    int index,
  ) {
    setState(() {
      selectedIndex = index;
    });
  }
}
