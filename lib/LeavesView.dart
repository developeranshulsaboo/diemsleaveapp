import 'package:LeaveApp/AccountView.dart';
import 'package:LeaveApp/LeaveForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:LeaveApp/ReplaceRequest.dart';

class LeavesView extends StatefulWidget {
  @override
  _LeavesViewState createState() => _LeavesViewState();
}

class _LeavesViewState extends State<LeavesView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LeaveForm()));
        },
        backgroundColor: Colors.blue[400],
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Leaves"),
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
  }

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
}
