import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_health_app/models/forum.dart';
import 'package:pet_health_app/models/user.dart';
import 'package:pet_health_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_health_app/services/auth.dart';
import 'package:pet_health_app/toDo/todos.dart';
import 'package:provider/provider.dart';
import 'package:pet_health_app/models/user.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future main() async {
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.black,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          soundSource:
              'resource://raw/android_app_src_main_res_raw_res_custom_notification')
    ],
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      // adding because of eroor
      initialData: null,
      // until here adding because of error

      child: ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
          home: Wrapper(),
        ),
      ),
      catchError: (_, __) => null,
    );
  }
}

createCollection(Forum forum) async {
  await FirebaseFirestore.instance.collection("Forum").add(forum.toJson());
}
