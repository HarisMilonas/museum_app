import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class RoleIndex extends StatefulWidget {
  const RoleIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<RoleIndex> createState() => _RoleIndexState();
}

class _RoleIndexState extends State<RoleIndex> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return  BaseLayout(
      user: widget.user,
      withFloatingButtons: true,
      scaffoldKey: _scaffoldKey,
      bodyWidget: const Center(
        child: Text("ROLES PAGEEEE!!!"),
      ),
    );
  }
}
