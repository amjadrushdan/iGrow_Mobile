import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/api.dart';

import '../nav.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;


  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: TextStyle(
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      validator: (emailInput) {
        if (emailInput!.isEmpty) {
          return 'Please enter your email!';
        }
        email = emailInput;
        return null;
      },
    );
    final passwordField = TextFormField(
      obscureText: true,
      style: TextStyle(
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      validator: (passwordInput) {
        if (passwordInput!.isEmpty) {
          return 'Please enter your password!';
        }
        password = passwordInput;
        return null;
      },
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: kPrimaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          // _login();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Nav()),
          );
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 200.0,
                        child: Image.asset("assets/images/login.png",
                            height: 200, width: 200)),
                    SizedBox(
                      height: 48,
                    ),
                    emailField,
                    SizedBox(
                      height: 24,
                    ),
                    passwordField,
                    SizedBox(
                      height: 24,
                    ),
                    loginButton
                  ],
                ),
              )),
        ),
      ),
    );
  }

  String? _myDataState;

  Widget loading() {
    return FutureBuilder(builder: (context, snapshot) {
      if (_myDataState == 'Loaded') {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          // Navigator.of(context).restorablePushNamed(SAgile.calendarRoute);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Nav()));
        });
      }
      if (_myDataState == 'Timeout') {
        return Column(
          children: [
            MaterialButton(
              color: Theme.of(context).backgroundColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.refresh,
              ),
              onPressed: _loads,
            ),
            const Text('Timed out!'),
          ],
        );
      }
      if (_myDataState == 'Loading') {
        return CircularProgressIndicator(
          color: Theme.of(context).backgroundColor,
        );
      }
      return MaterialButton(
        color: Theme.of(context).backgroundColor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.login,
        ),
        onPressed: _loads,
      );
    });
  }

  String? user;

  Future<void> _loads() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      String? _curState = 'Loading';

      setState(() {
        _myDataState = _curState;
      });

      _curState = await _login();
      setState(() {
        _myDataState = _curState;
      });
    }
  }

  Future _login() async {
    var data = {'Email': email, 'Pwd': password};

    return await loginAuthData(data)
        .timeout(const Duration(minutes: 1), onTimeout: () => 'Timeout');
  }

  Future loginAuthData(data) async {
    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body.toString());
    var success;
    if (body['success']) {
      print(body['user'].toString());
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('token', json.encode(body['token']));
      // localStorage.setString('user', json.encode(body['user']));
      // user = jsonDecode(localStorage.getString('user').toString());
      success = 'Loaded';
    }
    return success;
  }

  
}

