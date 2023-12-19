import 'package:flutter/material.dart';

// this class displays the searchbar and the add button on the inspections tests

class CustomSearchBarRow extends StatefulWidget {
  final Function(String)? onChangedSearchBar;

  final String hintLabel;
  // we use this widget in order to change the icons and clear the search bar in case of an input
  final Widget suffixIcon;
  final TextEditingController controller;

  const CustomSearchBarRow(
      {Key? key,
      required this.onChangedSearchBar,
      required this.hintLabel,
      required this.suffixIcon,
      required this.controller})
      : super(key: key);

  @override
  State<CustomSearchBarRow> createState() => _CustomSearchBarRowState();
}

class _CustomSearchBarRowState extends State<CustomSearchBarRow> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            textInputAction: TextInputAction.done,
            onChanged: widget.onChangedSearchBar,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintLabel,
              hintStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.all(8),
              isDense: true,
              filled: true,
              fillColor: const Color.fromARGB(179, 216, 216, 216),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
