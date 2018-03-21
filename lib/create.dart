import 'package:flutter/material.dart';
import 'package:memomo/http.dart';
import 'dart:async';

class CreatePageState extends State<CreatePage> with WidgetsBindingObserver{
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _contentController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String savedTitle = "";
  String savedContent = "";
  bool isSaved = false;
  String memoId;

  bool _hasUserEditedMemo() {
    //(title,content)->empty
    if(_titleController.text.isEmpty && _contentController.text.isEmpty){
      return false;
    }else if(_titleController.text == savedTitle && _contentController.text == savedContent){
      return false;
    }
    return true;
  }

  Future<bool> _askTosave() {
    if (_hasUserEditedMemo()) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        child: new AlertDialog(
          title: new Text('Do you want to save it?'),
          content: new Text(''),
          actions: <Widget>[
            new FlatButton(
              child: new Text('YES'),
              onPressed: () {
                isSaved
                    ? updateMemo(memoId,_titleController.text, _contentController.text)
                    : saveMemo(_titleController.text, _contentController.text).then((id) => memoId = id);
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
              child: new Text('Cancel'),
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
          content: new Text('Memo is empty!'),
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
              icon: new Icon(Icons.arrow_back),
              onPressed:_askTosave
          ),
          title: new Text(widget.title),
          elevation: 5.0,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.save),
              onPressed: (){
                if(_titleController.text.isNotEmpty || _contentController.text.isNotEmpty){
                  isSaved
                      ? updateMemo(memoId,_titleController.text, _contentController.text)
                      : saveMemo(_titleController.text, _contentController.text).then((id) => memoId = id);
                  isSaved
                      ? _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('updated')))
                      : _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('saved')));
                  isSaved = true;
                  savedTitle = _titleController.text;
                  savedContent = _contentController.text;
                }else{
                  _doNotSave();
                }
              },
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

