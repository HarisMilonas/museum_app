import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class UserIndex extends StatefulWidget {
  const UserIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<UserIndex> createState() => _UserIndexState();
}

class _UserIndexState extends State<UserIndex> {
     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return  BaseLayout(
      withFloatingButtons: true,
      scaffoldKey: _scaffoldKey,
        bodyWidget: const Center(child: Text("USERS PAGEEEE!!!"),), user: widget.user,);
  }
}
