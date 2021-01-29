import 'package:drawersample/screens/first.dart';
import 'package:drawersample/screens/fourth.dart';
import 'package:drawersample/screens/second.dart';
import 'package:drawersample/screens/third.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class MyHomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("First", Icons.shopping_basket),
    new DrawerItem("Second", Icons.category),
    new DrawerItem("Third", Icons.settings),
    new DrawerItem("Fourth", Icons.settings)
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new First();
      case 1:
        return new Second();
      case 2:
        return new Third();
      case 3:
        return new Fourth();
      default:
        return new Text("Error");
    }
  }

  // List<Widget> _widgetOptions = <Widget>[
  //   First(),
  //   Second(),
  //   Third(),
  //   Fourth(),
  // ];

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  void _onItemTapped(int index) {
    index == 4
        ? _scaffoldKey.currentState.openDrawer()
        : setState(() {
            _selectedDrawerIndex = index;
          });
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Vpsingh'),
              accountEmail: Text('viswanathsingh04@gmail.com'),
              currentAccountPicture: ClipOval(
                child: Image.asset(
                  'cardbackground_world.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedDrawerIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[800],
        selectedItemColor: Color.fromRGBO(10, 135, 255, 1),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Tabs',
            icon: Icon(Icons.tab_unselected_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Dropdown',
            icon: Icon(Icons.arrow_downward_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Date Picker',
            icon: Icon(Icons.date_range),
          ),
          BottomNavigationBarItem(
            label: 'Time',
            icon: Icon(Icons.timer_rounded),
          )
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
