import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  BaseLayout(
      drawer: MyNavigationDrawer(user: widget.user),
        bodyWidget: const Center(
      child: Text("HOME PAGEEEE!")
    ));
  }
}
