import 'package:flutter/material.dart';
import 'package:museum_app/componets/page_router.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/screens/category_page.dart';
import 'package:museum_app/view/screens/home.dart';

class MainList extends StatefulWidget {
  const MainList(
      {Key? key,
      required this.categoryItems,
      required this.imageHeight,
      required this.imageWidth,
      required this.itemTitle,
      required this.itemDescription,
      required this.user,
      this.isCategoryPage = true})
      : super(key: key);

  final List<String> categoryItems;
  final String itemTitle;
  final String itemDescription;
  final double imageHeight;
  final double imageWidth;
  final User? user;
  final bool isCategoryPage;

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.categoryItems
              .map((item) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.itemTitle,
                        // "TITLE FOR EXHIBIT CATEGORY",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(widget.itemDescription
                          // "Small description for the category here.Probably something small with not too much rows."
                          ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            CustomPageRouter.fadeThroughPageRoute(widget
                                    .isCategoryPage
                                ? CategoryPage(user: widget.user, image: item)
                                : HomePage(user: widget.user))),
                        child: Hero(
                          tag: 'image-id-$item',
                          child: Image(
                              width: widget.imageWidth,
                              height: widget.imageHeight,
                              image: NetworkImage(item)),
                        ),
                      )
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
