import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/componets/drawer/drawer_header.dart';
import 'package:museum_app/view/componets/drawer/menu_items.dart';


class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({
    Key? key,
   this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) => Drawer(
      
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MyDrawerHeader(context: context, user: user),
              MyMenuItems(
                context: context,
                user: user,
              ),
            ],
          ),
        ),
      );
}
