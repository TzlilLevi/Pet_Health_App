import 'package:flutter/material.dart';
import 'package:pet_health_app/services/auth.dart';
import 'package:pet_health_app/shared/constants.dart';
import 'package:pet_health_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.blue[50],
            appBar: AppBar(
                backgroundColor: Colors.blue,
                elevation: 0.0,
                title: Text(
                  'Sign in to Pet Health',
                  style: TextStyle(color: Colors.white),
                ),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(
                      Icons.person_add_alt_1_outlined,
                      color: Colors.white,
                    ),
                    label:
                        Text('Register', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      widget.toggleView();
                    },
                  )
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              // ignore: deprecated_member_use
              // child: RaisedButton(
              //   child: Text('Sign in anon'),
              //   onPressed: () async {
              //     dynamic result = await _auth.signInAnon();
              //     if (result == null) {
              //       print('error signing in');
              //     } else {
              //       print('signed in');
              //       print(result.uid);
              //     }
              //   },
              // ),

              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Container(
                            width: 300,
                            height: 200,
                            /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                            child: Image.asset(
                                'assets/images/pet_health_logo.png')),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter an password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 40.0),
                    SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              //print('valid');
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials';
                                  loading = false;
                                });
                              }
                            }
                          },
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ));
  }
}
