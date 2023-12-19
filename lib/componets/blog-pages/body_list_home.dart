import 'package:flutter/material.dart';
import 'package:museum_app/componets/page_router.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/screens/category_page.dart';
import 'package:museum_app/view/screens/home.dart';

class MainListHome extends StatefulWidget {
  const MainListHome({
    Key? key,
    required this.categoryItems,
    required this.imageHeight,
    required this.imageWidth,
    required this.itemTitle,
    required this.itemDescription,
    required this.user,
  }) : super(key: key);

  final List<String> categoryItems;
  final String itemTitle;
  final String itemDescription;
  final double imageHeight;
  final double imageWidth;
  final User? user;

  @override
  State<MainListHome> createState() => _MainListHomeState();
}

class _MainListHomeState extends State<MainListHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          CustomPageRouter.fadeThroughPageRoute(
                              CategoryPage(user: widget.user, image: item))),
                      child: Hero(
                        tag: 'image-id-$item',
                        child: Image(
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              // Image is fully loaded
                              return child;
                            } else {
                              // Image is still loading, show a CircularProgressIndicator
                              return SizedBox(
                                width: widget.imageWidth,
                                height: widget.imageHeight,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                  ),
                                ),
                              );
                            }
                          },
                          width: widget.imageWidth,
                          height: widget.imageHeight,
                          image: NetworkImage(item),
                        ),
                      ),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
