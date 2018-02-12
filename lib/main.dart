import 'package:flutter/material.dart';

class Choice {
  const Choice({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'sort', icon: Icons.sort),
  const Choice(title: 'search', icon: Icons.search),
];

List<Widget> list = <Widget>[
  new ListTile(
    title: new Text('memo1',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('2018/2/13'),
    leading: new Icon(
      Icons.insert_drive_file ,
      color: Colors.pink,
    ),
  ),
  new ListTile(
    title: new Text('memo2',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('2018/2/14'),
    leading: new Icon(
      Icons.insert_drive_file ,
      color: Colors.pink,
    ),
  ),
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 5.0, // Removing the drop shadow cast by the app bar.//
      ),
      body: new Center(
        child: new ListView(
          children: list,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'memomomo',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new MyHomePage(title: 'Memomomo'),
    );
  }
}

void main() => runApp(new MyApp());