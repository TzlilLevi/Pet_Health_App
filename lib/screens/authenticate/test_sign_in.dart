import 'package:flutter/material.dart';
import 'package:pet_health_app/screens/home/home.dart';
import 'package:pet_health_app/services/auth.dart';
import 'package:pet_health_app/shared/constants.dart';

class TestSignIn extends StatefulWidget {
  //const TestSignIn({Key? key}) : super(key: key);
  final Function toggleView;
  TestSignIn({required this.toggleView});
  @override
  _TestSignInState createState() => _TestSignInState();
}

class _TestSignInState extends State<TestSignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
          backgroundColor: Colors.red[700],
          title: Text("Pet Health Login Page",
              style: TextStyle(color: Colors.orange[50])),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person_add_alt_1_outlined),
              label: Text('Register'),
              onPressed: () {
                widget.toggleView();
              },
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logoPet.png')),
              ),
            ),
            Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                )),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val!.length < 6
                      ? 'Enter an password 6+ chars long'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                )),
            FlatButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.red[700], fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    //print('valid');
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                        loading = false;
                      });
                    }
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.orange[50], fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Text('New User? Create Account',
                style: TextStyle(color: Colors.red[700]))
          ],
        ),
      ),
    );
  }
}
