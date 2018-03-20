import 'package:http/http.dart' as http;




void saveMemo(title,content){
  DateTime currentDateTime = new DateTime.now();
  final url = "http://www.suzusupo-niiyan.ga/memomo/edit.php";
  http.post(url, body: {
    //"type":"",
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

void updateMemo(title,content){

}
