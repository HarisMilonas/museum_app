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
  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      bodyWidget: Center(
        child: Text("ROLES PAGEEEE!!!"),
      ),
    );
  }
}
