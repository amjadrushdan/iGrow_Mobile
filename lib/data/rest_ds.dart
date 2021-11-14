import 'dart:async';

// import 'package:login_app/utils/network_util.dart';
// import 'package:login_app/models/user.dart';
import '../utils/network_utils.dart';
import '../models/person.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://localhost:8000";
  static final LOGIN_URL = BASE_URL + "/Loginpage";
  static final _API_KEY = "somerandomkey";

  Future<Person> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "token": _API_KEY,
      "username": username,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new Person.map(res["person"]);
    });
  }
}