import 'package:flutter/material.dart';
import 'package:memomo/edit_create.dart';
import 'package:memomo/http.dart';

class CreatePageState extends EditCreatePageState {

  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed:(){askToSave("create");}
            ),
            title: new Text("memomo"),
            elevation: 5.0,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.save),
                onPressed: (){
                  if(titleController.text.isNotEmpty || contentController.text.isNotEmpty){
                    isSaved
                        ? updateMemo(memoId,titleController.text, contentController.text)
                        : saveMemo(titleController.text, contentController.text).then((id) => memoId = id);
                    isSaved
                        ? scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('updated')))
                        : scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('saved')));
                    isSaved = true;
                    savedTitle = titleController.text;
                    savedContent = contentController.text;
                  }else{
                    doNotSave();
                  }
                },
              ),
            ]
        ),

        body:new Column(
          children: <Widget>[
            new TextField(
              autofocus: true,
              controller: titleController,
              decoration: new InputDecoration(
                hintText: 'Title',
              ),
            ),
            new TextField(
              controller: contentController,
              maxLengthEnforced: false,
              maxLines: null,
              decoration: new InputDecoration(
                hintText: 'Content',
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

