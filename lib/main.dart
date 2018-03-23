import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memomo/create.dart';
import 'package:memomo/edit.dart';
import 'package:memomo/list_tile_with_id.dart';
import 'package:memomo/http.dart';
import 'dart:async';


class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _mainPageScaffoldKey = new GlobalKey<ScaffoldState>();
  List<ListTileWithId> _list = new List<ListTileWithId>();

  @override
  void initState() {
    _makeMemoList();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void  _makeMemoList() async{
    List<ListTileWithId> result = new List<ListTileWithId>();
    var memoData = await getMemo();

    for (var item in memoData) {
      result.add(new ListTileWithId(
        id:int.parse(item["id"]),
        title: new Text(item["title"],
            style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
        subtitle: new Text(item["content"]),
        leading: new Icon(
          Icons.insert_drive_file,
          color: Colors.pink,
        ),
        trailing: new Text(item["updated_at"]),
        onLongPress:() {_askAboutMemo(item["id"],item["title"],item["content"]);},
        onTap:() {_editMemo(item["id"],item["title"],item["content"]);} ,
      ));
    }

    if (!mounted) return;
    setState(() {
      _list = result;
    });
  }

  void _createMemo(){
    Navigator.push(context, new MaterialPageRoute<Null>(
        settings: const RouteSettings(name: "/create"),
        builder: (BuildContext context) => new CreatePage(title:widget.title),
    ));
  }

  void _editMemo(memoId,savedTitle,savedContent){
    Navigator.push(context, new MaterialPageRoute<Null>(
      settings: const RouteSettings(name: "/edit"),
      builder: (BuildContext context) => new EditPage(memoId,savedTitle,savedContent,title:widget.title),
    ));
  }

  Future<Null> _askAboutMemo(String id,String title,String content) async {
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
            child: const Text('Copy the title',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
          new SimpleDialogOption(
            onPressed: () {
              print(content);
              Clipboard.setData(new ClipboardData(text: content));
              _mainPageScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('copied')));
              Navigator.of(context).pop();
            },
            child: const Text('Copy the content',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
          new SimpleDialogOption(
            onPressed: () {
              Clipboard.setData(new ClipboardData(text: "# "+title+"\n"+content));
              _mainPageScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('copied')));
              Navigator.of(context).pop();
            },
            child: const Text('Copy the title & content',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
          new SimpleDialogOption(
            onPressed: () {
              deleteMemo(id);
              Navigator.of(context).pop();
            },
            child: const Text('Delete',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainPageScaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 5.0,
        actions: <Widget>[
          new IconButton( // action button
            icon: new Icon(Icons.sort),
            onPressed: () {},
          ),
          new IconButton( // action button
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
          new IconButton(
            icon:new Icon(Icons.sync),
            onPressed: (){_makeMemoList();},
          )
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
          children: _list
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed:_createMemo,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
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
