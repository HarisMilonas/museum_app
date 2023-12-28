import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout(
      {super.key,
      required this.bodyWidget,
      this.drawer,
      this.withFloatingButtons = false,
    
      required this.user});

  final User? user;
  final bool? withFloatingButtons;
  

  final Widget bodyWidget;
  final Widget? drawer;

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: widget.withFloatingButtons!
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      child: const Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  widget.user != null
                      ? InkWell(
                          onTap: () =>
                              _scaffoldKey.currentState!.openDrawer(),
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.2),
                            child: const Icon(Icons.menu),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          : null,
      resizeToAvoidBottomInset: false,
      drawer: widget.drawer,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.primary,
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.background.withBlue(200),
              Theme.of(context).colorScheme.secondary,
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
          child: widget.bodyWidget),
    );
  }
}
