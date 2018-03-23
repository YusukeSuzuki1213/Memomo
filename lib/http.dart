import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

Future<List<Map<String,dynamic>>> getMemo() async{
   final uri = new Uri.http('www.suzusupo-niiyan.ga', '/memomo/read.php', {'user_id':'1'});
   var httpClient = new HttpClient();
   var memoData;

  try {
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      print("Succeeded in getting memo data");
      var json = await response.transform(UTF8.decoder).join();
      memoData = JSON.decode(json);
      print(memoData);
      var index=0;
      for(var item in memoData){
        item.addAll({"index": index++ });
      }

    }else{
      print('Error getting memo data:\nHttp status ${response.statusCode}');
    }
  }catch (exception) {
    print('Failed getting memo data');
  }

  return memoData;
}


Future<String> saveMemo(title,content) async{
  final url = "http://www.suzusupo-niiyan.ga/memomo/create.php";
  var response = await http.post(url, body:
  {
    "user_id": "1",
    "title": title,
    "content": content,
    "created_at":new DateTime.now().toString(),
    "updated_at":new DateTime.now().toString()
  });
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    return response.body.toString();
}

void updateMemo(id,title,content){
  final url = "http://www.suzusupo-niiyan.ga/memomo/update.php";
  http.post(url, body: {
    "user_id": "1",
    "id":id,
    "title": title,
    "content": content,
    "updated_at":new DateTime.now().toString()
  }).then((response) {
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
  });

}

Future deleteMemo(String id){
  final url = "http://www.suzusupo-niiyan.ga/memomo/delete.php";
  http.post(url, body: {
    "user_id": "1",
    "id":id,
  }).then((response) {
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
  });
}
