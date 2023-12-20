import 'dart:convert';
import 'package:http/http.dart' as http;

class APIServices {
  Future<dynamic> getResponse() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://localhost:3000/getResponse'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var res = await response.stream.bytesToString();
      var data = json.decode(res);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }
}
