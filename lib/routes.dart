import 'package:flutter/material.dart';
import 'Screens/homepage/homepage.dart';
import 'Screens/login/login_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new HomePage(),
  '/' :          (BuildContext context) => new LoginScreen(),
};

