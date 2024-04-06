import 'package:flutter/material.dart';
import 'package:museum_app/api/exhibits.dart';
import 'package:museum_app/componets/blog-pages/blog_layout.dart';
import 'package:museum_app/componets/blog-pages/body_list_category.dart';

import 'package:museum_app/componets/blog-pages/header_image.dart';
import 'package:museum_app/componets/page_router.dart';
import 'package:museum_app/componets/styles/textstyles.dart';
import 'package:museum_app/models/exhibit.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/screens/exhibit_page.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
];

class CategoryPage extends StatefulWidget {
  const CategoryPage({required this.user, Key? key, required this.exhibit})
      : super(key: key);

  final User? user;
  final Exhibit exhibit;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String title = '';

  @override
  void initState() {
    title = widget.exhibit.category?.split('.').first.trim() ??
        widget.exhibit.category ??
        "Χωρίς Συγκεκριμένο όνομα κατηγορίας";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlogLayout(user: widget.user, mainColumnChildren: [
      HeaderImage(
          imageTexts: [
           widget.exhibit.pic1 != null 
           ?  SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: headerStyle2()),
                  const SizedBox(height: 10),
                  Text(
                    widget.exhibit.category ?? title,
                    style: headerStyle3(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: const ContinuousRectangleBorder()),
                      onPressed: () => Navigator.of(context).push(
                          CustomPageRouter.fadeThroughPageRoute(ExhibitPage(
                              user: widget.user, exhibit: widget.exhibit))),
                      child:  const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Περισσότερα" ,style: TextStyle(fontSize: 16),),
                          Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.white,
                          )
                        ],
                      )),
                  const SizedBox(height: 30),
                ],
              ),
            ) : const SizedBox()
          ],
          image: widget.exhibit.pic1 != null
              ? Image.memory(widget.exhibit.pic1!.data!).image
              : Image.asset("images/not_available2.png").image),
      FutureBuilder(
          future: getData(widget.exhibit.category ?? ""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String title = widget.exhibit.category?.split('.').first.trim() ??
                  widget.exhibit.category ??
                  "Χωρίς Συγκεκριμένο όνομα κατηγορίας";
              var categoryItems = snapshot.data!;
              return categoryItems.isNotEmpty
                  ? MainListCategory(
                      categoryItems: categoryItems,
                      imageHeight: 100,
                      imageWidth: 100,
                      itemTitle: title,
                      user: widget.user,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Text(
                          "Δεν υπάρχουν διαθέσιμα εκθέματα για αυτή την έκθεση.",
                          style: descriptionStyle2(context),
                        ),
                      ),
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

  Future<List<Exhibit>?> getData(String category) async {
    // depending on the URL path a different query is performed
    List<Exhibit>? results = await ExhibitApi().getExhibitsCategory(category);

    return results;
  }
}
