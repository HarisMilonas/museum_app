import 'package:flutter/material.dart';



TextStyle headerStyle1() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35);
}


TextStyle headerStyle2() {
  return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 30);
}


TextStyle headerStyle3() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
}

TextStyle descriptionStyle1(BuildContext context) {
  return  TextStyle(
      color: Theme.of(context).colorScheme.primary);
}

TextStyle descriptionStyle2(BuildContext context) {
  return  TextStyle(
      color: Theme.of(context).colorScheme.primary , fontSize: 18);
}

TextStyle descriptionStyle3(BuildContext context) {
  return  TextStyle(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.8) , fontSize: 22 , fontWeight: FontWeight.bold);
}
