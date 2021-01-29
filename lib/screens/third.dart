import 'package:flutter/material.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2023));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  int _value = 1;
  String selectedvalue;
  List<String> rdata = [
    "Annamalai",
    "Malarkodi",
    "Suganthi",
    "Jayanathi",
    "Vel",
    "Vps",
    "Anandhi"
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //drawer: navigationDrawer(),
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "This is Third page",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          overflow: TextOverflow.fade,
        ),
        Text("${selectedDate.toLocal()}".split(' ')[0]),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select date'),
        ),
        for (var i = 0; i < rdata.length; i++)
          ListTile(
            leading: Radio(
                value: i,
                groupValue: _value,
                onChanged: (val) {
                  setState(() {
                    _value = val;
                    print(_value.toString());
                  });
                }),
            title: Text(
              rdata[i],
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              overflow: TextOverflow.fade,
            ),
            onTap: () {
              final snackBar = SnackBar(
                content: Text(_value.toString()),
                action: SnackBarAction(
                  label: 'Selected value',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
      ],
    )));
  }
}
