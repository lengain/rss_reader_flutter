import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCenterViewController extends StatefulWidget {
  const UserCenterViewController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => UserCenterViewControllerState();
}

class UserCenterViewControllerState extends State<UserCenterViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        "UserCenterView",
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
    );
  }
}