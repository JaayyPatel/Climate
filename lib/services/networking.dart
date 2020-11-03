import 'dart:convert';
import 'package:http/http.dart' as http;


class Networkser{

    Networkser(this.url);
    final String url;
    Future getdata() async
    {
      http.Response response = await http.get(url);
      String data = response.body;

      return jsonDecode(data);
    }
  }
