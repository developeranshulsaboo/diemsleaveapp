import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SelectedChar { Yes, No }

class LeaveForm extends StatefulWidget {
  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  DateTimeRange selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    //print(picked);

    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
    print(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    SelectedChar _char = SelectedChar.No;
    return Scaffold(
      appBar: AppBar(
        title: Text(" Leave Form"),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Leave Form",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RaisedButton(
                elevation: 20,
                color: Colors.blue[400],
                onPressed: () => _selectDate(context),
                child: Text(
                  "Select Leave Date",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
