import 'package:flutter/material.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key, required this.bodyWidget, this.drawer});

  final Widget bodyWidget;
  final Widget? drawer;

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      drawer: widget.drawer,
      body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.background.withBlue(200),
              Theme.of(context).colorScheme.secondary,
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
          child: widget.bodyWidget),
    );
  }
}
