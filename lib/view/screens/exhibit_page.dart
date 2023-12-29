import 'dart:async';

import 'package:flutter/material.dart';

import 'package:museum_app/componets/blog-pages/blog_layout.dart';
import 'package:museum_app/componets/blog-pages/exhibit_image.dart';

import 'package:museum_app/models/exhibit.dart';

import 'package:museum_app/models/user.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

class ExhibitPage extends StatefulWidget {
  const ExhibitPage({required this.user, required this.exhibit, Key? key})
      : super(key: key);

  final User? user;
  final Exhibit exhibit;

  @override
  State<ExhibitPage> createState() => _ExhibitPageState();
}

class _ExhibitPageState extends State<ExhibitPage> {
  // String title = '';
  // String chronologisi = '';
  // String proelefsi = '';
  // String diastaseis = '';
  // String troposapoktisis = '';

  Map<String, String> fieldsMap = {};

  @override
  void initState() {
    _fixTexts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlogLayout(user: widget.user, mainColumnChildren: [
      ExhibitImage(
        exhibit: widget.exhibit,
      ),
      Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            ...fieldsMap.entries.map((entry) {
              return columnField(context, entry.value);
            }).toList(),
          ],
        ),
      )
    ]);
  }

  Column columnField(BuildContext context, String? field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(field!,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 18)),
        // Divider(
        //   color: Theme.of(context).colorScheme.primary,
        //   thickness: 2,
        // ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Future<List<String>> getData() async {
    await Future.delayed(const Duration(seconds: 1));
    return imgList;
  }

  void _fixTexts() {

    fieldsMap["chronologisi"] =
        "Χρονολόγηση: ${widget.exhibit.chronologisi == null || widget.exhibit.chronologisi == "" ? "Άγνωστη." : widget.exhibit.chronologisi}";

    if (widget.exhibit.eidos.isNotEmpty) {
      fieldsMap["eidos"] = " ${widget.exhibit.eidos}";
    }

    fieldsMap["proelefsi"] =
        "Προέλευση: ${widget.exhibit.proelefsi == null || widget.exhibit.proelefsi == "" ? "Άγνωστη." : widget.exhibit.proelefsi}";

    fieldsMap["diastaseis"] =
        "Διαστάσεις: ${widget.exhibit.diastaseis == null || widget.exhibit.diastaseis == "" ? "Άγνωστη." : widget.exhibit.diastaseis}";
    fieldsMap["troposapoktisis"] =
        "Τρόπος απόκτησης: ${widget.exhibit.troposapoktisis == null || widget.exhibit.troposapoktisis == "" ? "Άγνωστη." : widget.exhibit.troposapoktisis}";

    fieldsMap["thesi"] =
        "Θέση: ${widget.exhibit.thesi == null || widget.exhibit.thesi == "" ? "Άγνωστη." : widget.exhibit.thesi}";

    fieldsMap["paratiriseis"] =
        "Παρατηρήσεις: ${widget.exhibit.paratiriseis == null || widget.exhibit.paratiriseis == "" ? "" : widget.exhibit.paratiriseis}";
  }
}
