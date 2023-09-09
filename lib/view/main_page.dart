import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).colorScheme.secondary
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
      ),
    );
  }
}
