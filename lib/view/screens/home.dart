import 'dart:async';

import 'package:flutter/material.dart';

import 'package:museum_app/api/exhibits.dart';
import 'package:museum_app/componets/blog-pages/blog_layout.dart';
import 'package:museum_app/componets/blog-pages/body_list_home.dart';
import 'package:museum_app/componets/blog-pages/header_image.dart';
import 'package:museum_app/componets/styles/textstyles.dart';
import 'package:museum_app/models/exhibit.dart';
import 'package:museum_app/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlogLayout(user: widget.user, mainColumnChildren: [
      HeaderImage(
        image: const AssetImage('images/background.png'),
        imageTexts: [
          const SizedBox(height: 70),
          Text(
            "Ανακάλυψε τα",
            style: headerStyle2(),
          ),
          Text(
            "Εκθέματα",
            style: headerStyle1(),
          ),
          Text(
            "Ανακάλυψε τα εκθέματα και\nγνώρισε καλύτερα τον αρχαίο\nελληνικό πολιτισμό",
            style: headerStyle3(),
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.only(top: 5 , bottom:  5 , left: 20),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        child: const Row(
          children: [
            Text(
              "Μόνιμες Εκθέσεις",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
      ),
      FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var categoryItems = snapshot.data!;
              return MainListHome(
                categoryItems: categoryItems,
                imageHeight: 250,
                imageWidth: double.infinity,
                user: widget.user,
              );
            }
            if (snapshot.hasError) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const Center(
                  child: Text('Error fetching exhibits from database.'),
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          })
    ]);
  }

  Future<List<Exhibit>?> getData() async {
    // depending on the URL path a different query is performed

    List<Exhibit>? results = await ExhibitApi().getExhibits("categories");

    return results;
  }
}
