import 'package:drawersample/userdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  Future _getdata;
  String selectedvalue;


  @override
  void initState() {
    super.initState();
    _getdata = fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //drawer: navigationDrawer(),
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "This is Second page",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              overflow: TextOverflow.fade,
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder<UserData>(
              future: _getdata,
              builder:
                  (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                if (snapshot.hasData) {
                  List<Datum> datum = snapshot.data.data;
                  return DropdownButtonFormField(
                    hint: Text(
                      'Select Value',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                      overflow: TextOverflow.fade,
                    ),
                    isExpanded: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent))),
                    items: datum
                        .map((e) => DropdownMenuItem<String>(
                              value: e.firstName,
                              child: Text(
                                e.firstName,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                overflow: TextOverflow.fade,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedvalue = value;
                      });
                    },
                    value: selectedvalue,
                    onTap: null,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}

Future<UserData> fetchdata() async {
  final response = await http.get('https://reqres.in/api/users?page=1');
  if (response.statusCode == 200) {
    //print(response.body);
    return userDataFromJson(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
