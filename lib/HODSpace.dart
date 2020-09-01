import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class HODSpace extends StatefulWidget {
  @override
  _HODSpaceState createState() => _HODSpaceState();
}

class _HODSpaceState extends State<HODSpace> {
  List records;
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

  @override
  Widget build(BuildContext context) {
    fetchRequest();
    return Scaffold(
        body: records == null
            ? Center(
                child: Text("Loading....."),
              )
            : ListView.builder(
                itemCount: records.length,
                // ignore: missing_return
                itemBuilder: (BuildContext context, int index) {
                  for (index; index < records.length; index++) {
                    if (records[index]['fields']['Status'] == "Accepted") {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Request for Leave",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.blue[400],
                                  ),
                                ),
                                Text(records[index]["fields"]["Name"],
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
                                  records[index]["fields"]["DateRange"],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red[400],
                                  ),
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.blue[400]),
                                ),
                                Text(
                                  records[index]["fields"]["From"],
                                  style: TextStyle(
                                      color: Colors.red[400], fontSize: 20),
                                ),
                                Text(
                                  "Reason",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.blue[400]),
                                ),
                                Text(
                                  records[index]["fields"]["Reason"],
                                  style: TextStyle(
                                    color: Colors.red[400],
                                    fontSize: 20,
                                  ),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.blue[400],
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      var id = records[index]['id'];
                                      print(id);
                                      // updatestatus("Accepted", id);
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.red[400],
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      //status = "Declined";
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
                }));
  }
}
