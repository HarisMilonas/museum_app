import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/api/exhibits.dart';
import 'package:museum_app/componets/waiting_dialog.dart';
import 'package:museum_app/models/exhibit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imgList = [
  // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.background.withBlue(200),
            Theme.of(context).colorScheme.secondary
          ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () async {
                  List<Exhibit>? items = await ExhibitApi().getExhibits();
                  print(items!.length);
                },
                child: const Text('Hit API'),
              ),
              FutureBuilder(
                future: ExhibitApi().getExhibits(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return myCarousel(snapshot.data);
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error fetching exhibits from database.'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Widget> sa = imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  Widget myCarousel(List<Exhibit>? exhibits) {
    final List<Widget> imageSliders = createImageSliders(exhibits);
    print('we are inside the carousel function ${imageSliders.length}');
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 2,
        autoPlay: true,
      ),
      items: imageSliders,
    );
  }

  List<Widget> createImageSliders(List<Exhibit>? exhibits) {
    List<Widget> imageSliders = [];

    for (Exhibit exhibit in exhibits!) {
      print(exhibit.pic1?.data.toString());
      if (exhibit.pic1?.data != null) {

        var item = Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.memory(exhibit.pic1?.data as Uint8List),
                  // Image.network(item.pic1.pic, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'No. ${exhibits.indexOf(exhibit)} image',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );

        imageSliders.add(item);
      } else {
        continue;
      }
    }
    return imageSliders;
    // return exhibits!
    //     .map((item) => Container(
    //           margin: const EdgeInsets.all(5.0),
    //           child: ClipRRect(
    //               borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    //               child: Stack(
    //                 children: <Widget>[
    //                   Image.memory(item.pic1?.pic as Uint8List),
    //                   // Image.network(item.pic1.pic, fit: BoxFit.cover, width: 1000.0),
    //                   Positioned(
    //                     bottom: 0.0,
    //                     left: 0.0,
    //                     right: 0.0,
    //                     child: Container(
    //                       decoration: const BoxDecoration(
    //                         gradient: LinearGradient(
    //                           colors: [
    //                             Color.fromARGB(200, 0, 0, 0),
    //                             Color.fromARGB(0, 0, 0, 0)
    //                           ],
    //                           begin: Alignment.bottomCenter,
    //                           end: Alignment.topCenter,
    //                         ),
    //                       ),
    //                       padding: const EdgeInsets.symmetric(
    //                           vertical: 10.0, horizontal: 20.0),
    //                       child: Text(
    //                         'No. ${exhibits.indexOf(item)} image',
    //                         style: const TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               )),
    //         ))
    //     .toList();
  }
}
