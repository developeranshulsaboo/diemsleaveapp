import 'package:LeaveApp/HODSpace.dart';
import 'package:LeaveApp/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:LeaveApp/LeavesView.dart';
import 'package:LeaveApp/ReplaceRequest.dart';
import 'package:toast/toast.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final userid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    void onTappedItem(int index) {
      switch (index) {
        case 0:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LeavesView()));
          break;
        case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AccountView()));
          break;
        case 2:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReplacementRequest()));
          break;
      }
      setState(() {
        selectedIndex = index;
      });
    }

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var userstring = snapshot.data;
          String name = userstring.data()["Name"];
          String email = userstring.data()["Email"];
          String eid = userstring.data()["EID"];
          String dept = userstring.data()["Department"];
          String designation = userstring.data()["Designation"];
          var phone = userstring.data()["PhoneNumber"];
          // ignore: unused_local_variable
          bool adminstatus = userstring.data()["IsAdmin"];
          // ignore: unused_local_variable
          bool directorstatus = userstring.data()["IsDirector"];

          String src =
              "https://storage.googleapis.com/ezap-prod/colleges/8350/deogiri-institute-of-engineering-and-management-studies-aurangabad-logo-new.png";
          // ignore: non_constant_identifier_names
          final _NameController = TextEditingController(text: '$name');
          // ignore: non_constant_identifier_names
          final _EmailController = TextEditingController(text: '$email');
          // ignore: non_constant_identifier_names
          final _EidController = TextEditingController(text: '$eid');
          // ignore: non_constant_identifier_names
          final _DepartmentController = TextEditingController(text: '$dept');
          // ignore: non_constant_identifier_names
          final _DesignationController =
              TextEditingController(text: '$designation');
          // ignore: non_constant_identifier_names
          final _PhoneNumberController =
              TextEditingController(text: phone.toString());
          int admincode = 0;
          if (_DesignationController.text == 'HOD' ||
              _DesignationController.text == 'Director') {
            admincode = 1;
          } else {
            admincode = 0;
          }
          void admincheck() {
            if (_DesignationController.text == "HOD") {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HODSpace()));
            } else if (_DesignationController.text == "Director") {
              Navigator.push(context, MaterialPageRoute(builder: null));
            } else {
              Toast.show("Admin Access Denied", context,
                  gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
            }
          }

          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(src),
                      maxRadius: 40,
                    ),
                  ),
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.person), labelText: "Name"),
                          readOnly: true,
                          controller: _NameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.email), labelText: "Email"),
                          readOnly: true,
                          controller: _EmailController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.fingerprint), labelText: "E ID"),
                          readOnly: true,
                          controller: _EidController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              labelText: "Phone Number"),
                          readOnly: true,
                          controller: _PhoneNumberController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.apartment),
                              labelText: "Department"),
                          readOnly: true,
                          controller: _DepartmentController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.work), labelText: "Designation"),
                          readOnly: true,
                          controller: _DesignationController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 260,
                    height: 55,
                    child: RaisedButton(
                      color: Colors.red[400],
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      elevation: 20,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 260,
                    height: 55,
                    child: RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        "ADMIN SPACE",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      elevation: 20,
                      onPressed: () {
                        admincheck();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "Leaves"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: "Account"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.date_range,
                    ),
                    label: "Requests")
              ],
              currentIndex: selectedIndex,
              onTap: onTappedItem,
            ),
          );
        });
  }
}
