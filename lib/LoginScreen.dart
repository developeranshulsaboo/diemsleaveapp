import 'package:LeaveApp/LeavesView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: non_constant_identifier_names
  final _EmailController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _PasswordController = TextEditingController();
  String _email, _password;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _loginformkey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("assets/images/diemslogo.png")),
          Text(
            "LEAVE APPLICATION APP",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Form(
            key: _loginformkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 337,
                  child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.email), labelText: "Email"),
                      onSaved: (value) => _email = value,
                      onChanged: (value) {
                        _email = value;
                      },
                      controller: _EmailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email can\'t be Empty";
                        } else {
                          return null;
                        }
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 337,
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock_open), labelText: "Password"),
                    obscureText: true,
                    controller: _PasswordController,
                    onChanged: (value) {
                      _password = value;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 235,
                  height: 55,
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        // ignore: unused_local_variable
                        UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                                email: _email, password: _password);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeavesView()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          print("No User found for email");
                        } else if (e.code == "wrong-password") {
                          print("Wrong-Password");
                        }
                      }
                    },
                    color: Colors.blue[400],
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 235,
                  height: 55,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue[400],
                    child: Text(
                      "Request Access",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
