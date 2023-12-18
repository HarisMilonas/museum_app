import 'package:flutter/material.dart';

import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';


class BlogLayout extends StatefulWidget {
  const BlogLayout({required this.user, required this.mainColumnChildren, Key? key}) : super(key: key);

  final User? user;
  final List<Widget> mainColumnChildren;
  

  @override
  State<BlogLayout> createState() => _BlogLayoutState();
}

class _BlogLayoutState extends State<BlogLayout> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      withFloatingButtons: true,
      user: widget.user,
      drawer: MyNavigationDrawer(user: widget.user),
      bodyWidget: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: widget.mainColumnChildren
          ),
        ),
      ),
    );
  }
}
