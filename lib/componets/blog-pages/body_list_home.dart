import 'package:flutter/material.dart';
import 'package:museum_app/componets/page_router.dart';
import 'package:museum_app/componets/styles/textstyles..dart';
import 'package:museum_app/models/exhibit.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/screens/category_page.dart';

class MainListHome extends StatefulWidget {
  const MainListHome({
    Key? key,
    required this.categoryItems,
    required this.imageHeight,
    required this.imageWidth,
    required this.user,
  }) : super(key: key);

  final List<Exhibit> categoryItems;
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
        children: widget.categoryItems.map((item) {

            String title = item.category?.split('.').first.trim() ?? item.category ?? "Χωρίς Συγκεκριμένο όνομα κατηγορίας";


          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                // "TITLE FOR EXHIBIT CATEGORY",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(item.category ?? "", style: descriptionStyle1(context),
                  // "Small description for the category here.Probably something small with not too much rows."
                  ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                    CustomPageRouter.fadeThroughPageRoute(
                        CategoryPage(user: widget.user, exhibit: item))),
                child: Hero(
                    tag: 'image-id-${item.idexhibit}', child: dbImage(item)),
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  Image dbImage(Exhibit item) {
    return Image(
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
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          }
        },
        width: widget.imageWidth,
        height: widget.imageHeight,
        fit: BoxFit.fill,
        image: item.pic1 != null
            ? Image.memory(item.pic1!.data!).image
            : Image.asset("images/not_available2.png").image);
  }
}
