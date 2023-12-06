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
    return BaseLayout(
      withFloatingButtons: true,
      user: widget.user,
      drawer: MyNavigationDrawer(user: widget.user),
        bodyWidget: 
            Padding(
             padding: const EdgeInsets.only(top: 50.0 , bottom: 10 , left: 15 , right: 15),
             child: Column(
              children: [
                // Container(
                //   width: double.infinity,
                //   height: 300,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(image: AssetImage('images/background.png'), fit: BoxFit.cover)
                //   ),
                //   child: const Text("Ανακάλυψε τα\nεκθέματα",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                // )
              ],
                     ),
           ),
        
    );
  }
}
