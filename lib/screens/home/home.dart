// import 'package:flutter/material.dart';
// import 'package:pet_health_app/models/pet.dart';
// import 'package:pet_health_app/repository/data_repository.dart';
// import 'package:pet_health_app/services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Home extends StatelessWidget {
//   //const Home({Key? key}) : super(key: key);

//   final AuthService _auth = AuthService();
//   final DataRepository repository = DataRepository();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[50],
//       appBar: AppBar(
//         title: Text('Pet Health'),
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         actions: <Widget>[
//           FlatButton.icon(
//             icon: Icon(Icons.logout_outlined),
//             label: Text('Logout'),
//             onPressed: () async {
//               await _auth.signOut();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/blocks/application_block.dart';
import 'package:pet_health_app/calendar/calendar.dart';
import 'package:pet_health_app/forum/forum_home.dart';
import 'package:pet_health_app/home_list.dart';
import 'package:pet_health_app/professionals.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final DataRepository repository = DataRepository();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our App would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Don\'t Allow',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeList(),
      Professionals(),
      Calendar(),
      ForumHome(),
    ];
    return ChangeNotifierProvider(
        create: (context) => ApplicationBlock(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text('Pet Health'),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.logout_outlined),
                label: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'My Pets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Forum',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          ),
        ));
  }
}
