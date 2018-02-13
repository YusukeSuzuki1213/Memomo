import 'package:flutter/material.dart';
import 'package:memomo/create.dart/';
class Choice {
  const Choice({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'sort', icon: Icons.sort),
  const Choice(title: 'search', icon: Icons.search),
  const Choice(title: 'memo', icon: Icons.insert_drive_file),
  const Choice(title: 'add', icon: Icons.add),


];

List<Widget> list = <Widget>[
  new ListTile(
    title: new Text('memo1',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('2018/2/13'),
    leading: new Icon(
      choices[2].icon,
      color: Colors.pink,
    ),
  ),
  new ListTile(
    title: new Text('memo2',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('2018/2/14'),
    leading: new Icon(
      choices[2].icon,
      color: Colors.pink,
    ),
  ),
];

class _MyHomePageState extends State<MyHomePage> {

  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    setState(() { // Causes the app to rebuild with the new _selectedChoice.
      _selectedChoice = choice;
    });
  }

  void createMemo(){
    Navigator.push(context, new MaterialPageRoute<Null>(
        settings: const RouteSettings(name: "/create"),
        builder: (BuildContext context) => new CreatePage(title:widget.title),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 5.0,
        actions: <Widget>[
          new IconButton( // action button
            icon: new Icon(choices[0].icon),
            onPressed: () { _select(choices[0]); },
          ),
          new IconButton( // action button
            icon: new Icon(choices[1].icon),
            onPressed: () { _select(choices[1]); },
          ),
          new PopupMenuButton<Choice>( // overflow menu
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return new PopupMenuItem<Choice>(
                  value: choice,
                  child: new Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: new Center(
        child: new ListView(
          children: list,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed:createMemo,
        tooltip: 'Increment',
        child: new Icon(choices[3].icon),
      ), // T
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
      home: new MyHomePage(title: 'Memomo'),
    );
  }
}

void main() => runApp(new MyApp());
