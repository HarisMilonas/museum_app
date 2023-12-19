import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:museum_app/componets/blog-pages/blog_layout.dart';
import 'package:museum_app/componets/blog-pages/body_list_home.dart';
import 'package:museum_app/componets/blog-pages/header_image.dart';
import 'package:museum_app/componets/styles/textstyles..dart';
import 'package:museum_app/models/user.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

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
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.black,
        child: const Center(
          child: Text(
            "Μόνιμες Εκθέσεις",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
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
                itemTitle: "TITLE FOR EXHIBIT CATEGORY",
                itemDescription:
                    "Small description for the category here.Probably something small with not too much rows.",
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

  Future<List<String>> getData() async {
    await Future.delayed(const Duration(seconds: 1));
    return imgList;
  }
}
