import 'package:flutter/material.dart';
import 'package:pukgyshppingmall/screens/home.dart';


void main() {
  runApp(MyApp());
}

//ผ้าปูโต๊ะที่ถูกตกแต่งเรียบร้อย
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
