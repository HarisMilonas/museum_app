import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class RoleIndex extends StatefulWidget {
  const RoleIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<RoleIndex> createState() => _RoleIndexState();
}

class _RoleIndexState extends State<RoleIndex> {
  @override
  Widget build(BuildContext context) {
    return  BaseLayout(
      drawer: MyNavigationDrawer(user: widget.user,),
      user: widget.user,
      withFloatingButtons: true,
      bodyWidget: const Center(
        child: Text("ROLES PAGEEEE!!!"),
      ),
    );
  }
}
