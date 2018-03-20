import 'package:flutter/material.dart';
import 'package:memomo/icons.dart';
import 'package:memomo/http.dart';
import 'dart:async';

class CreatePageState extends State<CreatePage> with WidgetsBindingObserver{
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _contentController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String savedTitle = "";
  String savedContent = "";
  bool isSaved = false;

  bool _hasUserEditedMemo() {
    //(title,content)->empty
    if(_titleController.text.isEmpty && _contentController.text.isEmpty){
      return false;
    }else if(_titleController.text == savedTitle && _contentController.text == savedContent){
      return false;
    }
    return true;
  }
  Future<bool> _requestPop() {
    if (_hasUserEditedMemo()) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        child: new AlertDialog(
          title: new Text('保存しますか？'),
          content: new Text(''),
          actions: <Widget>[
            new FlatButton(
              child: new Text('YES'),
              onPressed: () {
                isSaved
                  ? updateMemo(_titleController.text, _contentController.text)
                  :saveMemo(_titleController.text, _contentController.text);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      return new Future.value(false);
    } else {
      Navigator.of(context).pop();
      return new Future.value(true);
    }
  }

  Future<bool> _doNotSave() {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        child: new AlertDialog(
          title: new Text('You can\'t save memo'),
          content: new Text('なんか書け'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return new Future.value(false);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          leading: new IconButton(
              icon: new Icon(choices[5].icon),
              onPressed:_requestPop
          ),
          title: new Text(widget.title),
          elevation: 5.0,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(choices[4].icon),
              onPressed: (){
                if(_titleController.text.isNotEmpty || _contentController.text.isNotEmpty){
                  isSaved
                      ? updateMemo(_titleController.text, _contentController.text)
                      : saveMemo(_titleController.text, _contentController.text);
                  isSaved
                      ? _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('updated')))
                      : _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('saved')));
                  isSaved = true;
                  savedTitle = _titleController.text;
                  savedContent = _contentController.text;
                }else{
                  _doNotSave();
                }
              },//保存処理,
            ),
          ]
      ),

      body:new Column(
      children: <Widget>[
        new TextField(
          controller: _titleController,
          decoration: new InputDecoration(
              hintText: 'Title',
            ),
          ),
        new TextField(
          controller: _contentController,
          maxLengthEnforced: false,
          maxLines: null,
          decoration: new InputDecoration(
            hintText: '',
            ),
          ),
        ],
      )
    );


    }

  }



class CreatePage extends StatefulWidget {
  final String title;
  CreatePage({Key key, this.title}) : super(key: key);

  @override
  CreatePageState createState() => new CreatePageState();
}

