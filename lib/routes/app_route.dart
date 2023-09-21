import 'package:bayarspp_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bayarspp_app/main.dart';
import 'package:bayarspp_app/pages/login_page.dart';
import 'package:bayarspp_app/pages/history_page.dart';
// import 'package:bayarspp_app/pages/register_page.dart';

class AppRoutes {
  AppRoutes._();

  static const orderPage = '/order';
  static const loginPage = '/login-user';
  static const historyPage = '/bayarsekarangs';
  static const registerPage = '/register';
  static const myApp = '/myApp';

  static final routes = <String, WidgetBuilder>{
    loginPage: (_) => const LoginPage(),
    historyPage: (_) => const HistoryPage(),
    // registerPage: (_) => const RegisterPage(),
    orderPage: (_) => const HomePage(),
    myApp: (_) => const MyApp(),
  };
}