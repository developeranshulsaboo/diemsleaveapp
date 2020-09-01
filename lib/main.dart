import 'package:LeaveApp/LeavesView.dart';
import 'package:LeaveApp/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
              child: SizedBox(
            width: 353,
            height: 353,
            child: Image.asset("assets/images/diemslogo.png"),
          )),
          Center(
              child: SizedBox(
            height: 206,
            child: Text(
              "LEAVE APPLICATION APP",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          )),
          Center(
              child: SizedBox(
                  width: 235,
                  height: 55,
                  child: RaisedButton(
                    color: Colors.blue[400],
                    onPressed: () async {
                      // ignore: await_only_futures
                      User user = await FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LeavesView()),
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  )))
        ],
      ),
    );
  }
}
