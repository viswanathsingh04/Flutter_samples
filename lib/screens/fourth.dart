import 'package:flutter/material.dart';

class Fourth extends StatefulWidget {
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //drawer: navigationDrawer(),
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "This is Fourth page",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          overflow: TextOverflow.fade,
        ),
        Text("${selectedTime.hour}" + "${selectedTime.minute}"),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          onPressed: () => _selectTime(context),
          child: Text('Select Time'),
        ),
      ],
    )));
  }
}
