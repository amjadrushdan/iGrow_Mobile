import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/homepage/homepage.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/login.png",
              height: size.height * 0.35,
            ),

            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),

            RoundedPasswordField(
              onChanged: (value) {},
            ),

            RoundedButton(
              text: "LOGIN",
              press: () {
                if(true){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                }
              }
            ),

            SizedBox(height: size.height * 0.03),

          
          ],
        ),
      ),
    );
  }
}
