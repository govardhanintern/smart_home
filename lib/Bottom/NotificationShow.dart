import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationShow extends StatefulWidget {
  const NotificationShow({Key key}) : super(key: key);

  @override
  _NotificationShowState createState() => _NotificationShowState();
}

class _NotificationShowState extends State<NotificationShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notification Page"),
      ),
    );
  }
}
