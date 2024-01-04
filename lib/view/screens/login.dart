import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/api/exhibits.dart';
import 'package:museum_app/componets/miscellanious.dart';
import 'package:museum_app/models/exhibit.dart';
import 'package:museum_app/componets/bottom_sheet_login.dart';
import 'package:museum_app/view/layouts/base_layout.dart';
import 'package:museum_app/view/screens/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<List<Exhibit>?>? _future;



  @override
  void initState() {
    _future = ExhibitApi().getExhibits("exhibits");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      user: null,
      bodyWidget: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Καλώς ήρθατε στο',
                  style: TextStyle(
                      fontSize: 35,
                      color: CustomColors.lettersColor.withOpacity(0.6)),
                ),
              ),
              const SizedBox(height: 15),
              const IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage('images/logo.png'),
                      height: 80,
                      width: 150,
                    ),
                    VerticalDivider(
                      width: 20,
                      thickness: 1,
                      color: CustomColors.lettersColor,
                    ),
                    Text(
                      'ΜΟΥΣΕΙΟ\nΑΡΧΑΙΟΤΗΤΩΝ\nΗΡΑΚΛΕΙΟΥ',
                      style: TextStyle(
                          fontSize: 20,
                          color: CustomColors.lettersColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              FutureBuilder(
                future: _future,
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
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size(CustomSizes.maxWidth(context) - 70, 50)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: const RouteSettings(name: "HomePage"),
                            builder: (context) => const HomePage(user: null)));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Ξεκινήστε εδώ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_sharp)
                    ],
                  )),
              const SizedBox(height: 30),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Θες να λαμβάνεις νέα και ειδοποιήσεις;",
                        style: TextStyle(
                            fontSize: 14,
                            color: CustomColors.lettersColor.withOpacity(0.7)),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) =>
                                  const LoginBottomSheet(isEnlisted: true,));
                        },
                        child: const Text(
                          "Εγγραφή",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: CustomColors.lettersColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Έισαι μέλος του προσωπικού;",
                        style: TextStyle(
                            fontSize: 14,
                            color: CustomColors.lettersColor.withOpacity(0.7)),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) =>
                                  const LoginBottomSheet(isEnlisted: false,));
                        },
                        child: const Text(
                          "Σύνδεση",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: CustomColors.lettersColor),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myCarousel(List<Exhibit>? exhibits) {
    final List<Widget> imageSliders = createImageSliders(exhibits);
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
      if (exhibit.pic1?.data != null) {
        var item = Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.memory(
                  exhibit.pic1?.data as Uint8List,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).viewInsets.horizontal,
                  height: 400,
                ),
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
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Text(
                      exhibit.chronologisi!.isEmpty
                          ? "Άγνωστη χρονολόγηση"
                          : exhibit.chronologisi ?? "Άγνωστη χρονολόγηση",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        imageSliders.add(item);
      } else {
        continue;
      }
    }
    return imageSliders;
  }
}
