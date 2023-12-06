import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class UserIndex extends StatefulWidget {
  const UserIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<UserIndex> createState() => _UserIndexState();
}

class _UserIndexState extends State<UserIndex> {
   
  @override
  Widget build(BuildContext context) {
    return  BaseLayout(
      drawer: MyNavigationDrawer(user: widget.user,),
      withFloatingButtons: true,
        bodyWidget: const Center(child: Text("USERS PAGEEEE!!!"),), user: widget.user,);
  }
}
