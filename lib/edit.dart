import 'package:flutter/material.dart';
import 'package:memomo/edit_create.dart';
import 'package:memomo/http.dart';

class EditPageState extends EditCreatePageState{

  EditPageState(id,title,content){
    memoId = id;
    titleController.text = title;
    contentController.text = content;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed:(){askToSave("edit");}
            ),
            title: new Text("memomo"),
            elevation: 5.0,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.save),
                onPressed: (){
                  if(titleController.text.isNotEmpty || contentController.text.isNotEmpty){
                    updateMemo(memoId,titleController.text, contentController.text);
                    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('updated')));
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

class EditPage extends StatefulWidget {
  final String title;
  final String memoId;
  final String savedTitle;
  final String savedContent;

  EditPage(this.memoId,this.savedTitle,this.savedContent,{Key key, this.title}) : super(key: key);

  @override
  EditPageState createState() => new EditPageState(memoId,savedTitle,savedContent);
}