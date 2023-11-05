import 'package:flutter/material.dart';
import 'package:pet_health_app/home_list.dart';
import 'package:pet_health_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:pet_health_app/models/user.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  //const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print(user);
    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
