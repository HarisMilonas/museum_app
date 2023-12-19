import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class ExhibitsIndex extends StatefulWidget {
  const ExhibitsIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<ExhibitsIndex> createState() => _ExhibitsIndexState();
}

class _ExhibitsIndexState extends State<ExhibitsIndex> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        user: widget.user,
        drawer: MyNavigationDrawer(
          user: widget.user,
        ),
        withFloatingButtons: true,
        bodyWidget: const Center(
          child: Text("EXHIBITS PAGE!!!!"),
        ));
  }
}
