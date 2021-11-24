import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final _url = 'http://10.0.2.2:8000/rest-auth';
  String? token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token').toString())['token'];
  }

  authData(data, apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl);
    await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
