import 'package:bayarspp_app/pages/history_page.dart';
import 'package:bayarspp_app/pages/home_page.dart';
import 'package:bayarspp_app/pages/payment_page.dart';
import 'package:dio/dio.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:bayarspp_app/constants/api_config.dart';
import 'package:bayarspp_app/locals/secure_storage.dart';
import 'package:bayarspp_app/pages/login_page.dart';
import 'package:bayarspp_app/routes/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  // await SecureStorage.deleteDataLokal();
  final token = await SecureStorage.getToken();
  final isLogin = token != null;
  runApp(MyAppMaterial(
    home: isLogin ? MyApp() : LoginPage(),
  ));
}

class MyAppMaterial extends StatelessWidget {
  MyAppMaterial({Key? key, required this.home}) : super(key: key);
  Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        home: home);
  }
}

class MyApp extends StatefulWidget {
  final int i;

  const MyApp({Key? key, this.i = 0}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final pages = [
    HomePage(),
    HistoryPage(),
    PaymentPage(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.i != 0) {
      setState(() {
        _index = widget.i;
      });
    }
    return Scaffold(
      body: DoubleBackToCloseApp(
        child: pages[_index],
        snackBar: SnackBar(content: Text('Tekan lagi untuk keluar aplikasi')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xffCC000000),
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('image/home.png', width: 30, height: 30),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset('image/history.png', width: 35, height: 35),
              label: 'History'),
          BottomNavigationBarItem(
              icon: Image.asset('image/wallet.png', width: 30, height: 30),
              label: 'Payment'),
        ],
      ),
    );
  }
}
