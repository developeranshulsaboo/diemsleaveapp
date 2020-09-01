import 'dart:convert';
import 'package:dart_airtable/dart_airtable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:LeaveApp/AccountView.dart';
import 'package:LeaveApp/LeavesView.dart';
import 'package:http/http.dart' as http;

// TODO: need to check the filtering process
// TODO: Accept and Reject method

class ReplacementRequest extends StatefulWidget {
  @override
  _ReplacementRequest createState() => _ReplacementRequest();
}

class _ReplacementRequest extends State<ReplacementRequest> {
  var useremail = FirebaseAuth.instance.currentUser.email;
  int selectedIndex = 2;
  String status;
  List records;

  /*Future UpdateRecord() async {
    String apikey = "";
    String basedid = "";
    St
  } */

  // ignore: missing_return
  Future<List> fetchRequest() async {
    String url =
        "https://api.airtable.com/v0/app63CdwHqiltUc00/RequestReplacement?&view=Grid%20view";
    Map<String, String> header = {"Authorization": "Bearer keyxSmsAvXynpKA6x"};
    http.Response res = await http.get(url, headers: header);
    Map<String, dynamic> result = json.decode(res.body);
    records = result['records'];
    print(records);

    setState(() {});
  }

/*  Future updatestatus(status, id) async {
    final String api = "keyxSmsAvXynpKA6x";
    final String base = "app63CdwHqiltUc00";
    final String table = "RequestReplacement";

    var airtable = Airtable(apiKey: api, projectBase: base);
    var records = airtable.updateRecord(table, id);
    print(records);
  } */

  @override
  Widget build(BuildContext context) {
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

    fetchRequest();
    return Scaffold(
      body: records == null
          ? Center(
              child: Text("Loading"),
            )
          : ListView.builder(
              itemCount: this.records.length,
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                for (index; index < this.records.length; index++) {
                  if (this.records[index]['fields']['To'] == useremail &&
                      this.records[index]["fields"]["Status"] == "pending") {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Request for Replacement",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "From",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.blue[400],
                                ),
                              ),
                              Text(this.records[index]["fields"]["From"],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red[400],
                                  )),
                              Text(
                                "Requested Date",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.blue[400],
                                ),
                              ),
                              Text(
                                this.records[index]["fields"]["Date"],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red[400],
                                ),
                              ),
                              Text(
                                "Hall Number",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.blue[400]),
                              ),
                              Text(
                                this.records[index]["fields"]["hallno"],
                                style: TextStyle(
                                    color: Colors.red[400], fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RaisedButton(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.blue[400],
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () async {
                                    var id = this.records[index]['id'];
                                    print(id);
                                    // updatestatus("Accepted", id);
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.red[400],
                                  child: Text(
                                    "Decline",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    status = "Declined";
                                  }),
                            ],
                          )
                        ],
                      ),
                    );
                  } // else if (this.records[index]["fields"]["To"] != useremail) {

                  //}
                  ;
                }
              }),
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
}
