import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memomo/create.dart';
import 'package:memomo/icons.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';



class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _mainPageScaffoldKey = new GlobalKey<ScaffoldState>();
  Choice _selectedChoice = choices[0];
  final url = "http://www.suzusupo-niiyan.ga/memomo/read.php";
  List<Widget> list = new List<Widget>();


  void  makeMemoList() async{
    final uri = new Uri.http('www.suzusupo-niiyan.ga', '/memomo/read.php', {'user_id':'1'});
    var httpClient = new HttpClient();
    List<Widget> result = new List<Widget>();
    var memoData;

    try {
      var request = await httpClient.postUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        print("Succeeded in getting memo data");
        var json = await response.transform(UTF8.decoder).join();
        memoData = JSON.decode(json);
      }else{
        print('Error getting memo data:\nHttp status ${response.statusCode}');
      }
    }catch (exception) {
      print('Failed getting memo data');
    }

    for (var item in memoData) {
      result.add(new ListTile(
        title: new Text(item["title"],
            style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
        subtitle: new Text(item["content"]),
        leading: new Icon(
          choices[2].icon,
          color: Colors.pink,
        ),
        trailing: new Text(item["updated_at"]),
        onLongPress:() {_askedToLead(item["title"],item["content"]);},
        //onTap: ,
      ));
    }
    if (!mounted) return;

    setState(() {
      print(result);
      list = result;
    });

  }

  Future<Null> _askedToLead(String title,String content) async {
    await showDialog<Null>(
      context: context,
      child: new SimpleDialog(
        contentPadding:new EdgeInsets.all(8.0),
        children: <Widget>[
          new SimpleDialogOption(
            onPressed: () {
              print(title);
              Clipboard.setData(new ClipboardData(text: title));
              _mainPageScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('copied')));
              Navigator.of(context).pop();
            },
            child: const Text('タイトルをコピー',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
          new SimpleDialogOption(
            onPressed: () {
              print(content);
              Clipboard.setData(new ClipboardData(text: content));
              _mainPageScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('copied')));
                  Navigator.of(context).pop();
            },
            child: const Text('メモをコピー',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
          new SimpleDialogOption(
            onPressed: () {
              Clipboard.setData(new ClipboardData(text: title+"\n"+content));
              _mainPageScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('copied')));
              Navigator.of(context).pop();
              },
            child: const Text('タイトルとメモをコピー',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
          new SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('削除',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
        ],
      ),
    );
  }

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
  void initState() {
    makeMemoList();
    print("oncreate was called");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    print("dispose was called");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainPageScaffoldKey,
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
//          new PopupMenuButton<Choice>( // overflow menu
//            onSelected: _select,
//            itemBuilder: (BuildContext context) {
//              return choices.skip(2).map((Choice choice) {
//                return new PopupMenuItem<Choice>(
//                  value: choice,
//                  child: new Text(choice.title),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new Center(
        child: new ListView(
          children: list
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
      home: new Scaffold(body: new MyHomePage(title:"Memomo")),
    );
  }
}

void main() => runApp(new MyApp());
