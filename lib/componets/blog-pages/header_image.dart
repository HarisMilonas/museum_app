import 'package:flutter/material.dart';

class HeaderImage extends StatefulWidget {
  const HeaderImage({Key? key, required this.image, this.imageTexts})
      : super(key: key);

  final ImageProvider<Object> image;
  final List<Widget>? imageTexts;

  @override
  State<HeaderImage> createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: widget.image,
              // AssetImage('images/background.png')
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.imageTexts ?? []),
      ),
    );
  }
}
