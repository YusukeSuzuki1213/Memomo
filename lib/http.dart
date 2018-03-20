import 'package:flutter/material.dart';
import 'package:memomo/main.dart' as main;
import 'package:http/http.dart' as http;
import 'package:memomo/icons.dart';
import 'dart:convert';


List<Widget> list = new List<Widget>();


void saveMemo(title,content){
  DateTime currentDateTime = new DateTime.now();
  final url = "http://www.suzusupo-niiyan.ga/memomo/edit.php";
  http.post(url, body: {
    "user_id": "1",
    "title": title,
    "content": content,
    "created_at":currentDateTime.toString(),
    "updated_at":currentDateTime.toString()
  }).then((response) {
    //print("Response status: ${response.statusCode}");
    //print("Response body: ${response.body}");
  });
}
