import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/upload_and_download_docs/display_files.dart';
import 'package:pet_health_app/upload_and_download_docs/upload_files.dart';

class DocsBottomBar extends StatefulWidget {
  final Pet pet;
  final String subject;
  const DocsBottomBar({Key? key, required this.pet, required this.subject})
      : super(key: key);

  @override
  State<DocsBottomBar> createState() => _DocsBottomBarState();
}

class _DocsBottomBarState extends State<DocsBottomBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      UploadFiles(
        pet: widget.pet,
        subject: widget.subject,
      ),
      DisplayFiles(pet: widget.pet, subject: widget.subject),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject + " Docs"),
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
            icon: Icon(Icons.cloud_upload_outlined),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fileAlt),
            label: widget.pet.name + '\'s ' + widget.subject + ' Docs',
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
