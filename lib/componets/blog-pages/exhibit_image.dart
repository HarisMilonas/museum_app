import 'package:flutter/material.dart';
import 'package:museum_app/componets/styles/textstyles.dart';
import 'package:museum_app/models/exhibit.dart';

class ExhibitImage extends StatefulWidget {
  const ExhibitImage({
    Key? key,
  
    required this.exhibit
  }) : super(key: key);


  final Exhibit exhibit;

  @override
  State<ExhibitImage> createState() => _ExhibitImageState();
}

class _ExhibitImageState extends State<ExhibitImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Stack(
            children: [
              Center(
                child: Image(
                  fit: BoxFit.fill,
                      image: widget.exhibit.pic1 != null
            ? Image.memory(widget.exhibit.pic1!.data!).image
            : Image.asset("images/not_available2.png").image,
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0 , left: 10 , right:  10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(widget.exhibit.category ?? "",
                  style: descriptionStyle2(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
