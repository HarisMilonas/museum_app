import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:museum_app/componets/blog_pages/blog_layout.dart';
import 'package:museum_app/componets/blog_pages/body_list_home.dart';
import 'package:museum_app/componets/blog_pages/header_image.dart';
import 'package:museum_app/componets/styles/textstyles..dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';
import 'package:museum_app/view/screens/category_page.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

class ExhibitPage extends StatefulWidget {
  const ExhibitPage({required this.user, required this.image, Key? key})
      : super(key: key);

  final User? user;
  final String image;

  @override
  State<ExhibitPage> createState() => _ExhibitPageState();
}

class _ExhibitPageState extends State<ExhibitPage> {
  @override
  Widget build(BuildContext context) {
    return BlogLayout(user: widget.user, mainColumnChildren: [
      HeaderImage(
        image: NetworkImage(widget.image),
        imageTexts: const [],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text("Ο τίτλος του εκθέματος που βλέπουμε παραπάνω.",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 18)),
            const SizedBox(
              height: 5,
            ),
            Text(
                " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed elit porttitor nisi viverra pellentesque nec volutpat sapien. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus non diam eu diam molestie vehicula semper sodales leo. Vivamus bibendum interdum neque, nec sodales erat egestas id. Aenean vel purus eget felis auctor dignissim. Proin vitae erat a nisi tincidunt bibendum. Vivamus maximus pharetra quam, ut pharetra mi dignissim ut.",
                style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    fontSize: 16))
          ],
        ),
      )
    ]);
  }

  Future<List<String>> getData() async {
    await Future.delayed(const Duration(seconds: 1));
    return imgList;
  }
}
