
import 'package:flutter/material.dart';
class InitScreen extends StatefulWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
         child: Text("InitScreen"),
       ),
    );
  }
}