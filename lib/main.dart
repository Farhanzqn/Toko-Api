import 'package:flutter/material.dart';
import 'package:my_flutter_project/Ui/Login/Sign_in.dart';
import 'package:my_flutter_project/Ui/Produk/Produk_page.dart';
import 'package:my_flutter_project/helpers/user_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const ProdukPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOKO KITA',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
