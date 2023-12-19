import 'package:flutter/material.dart';

class FilterSheetLayout extends StatefulWidget {
  final Widget closeFiltersInkwell; // Widget for closing the filters sheet
  final Widget sortByExpansionTile; // Widget for sorting options
  final Widget? checkBoxListTile; // Widget for checkboxes and filters
   final Widget
      bottomRowStreamBuilder; // Widget for the bottom row (possibly dynamic)

  final Widget? extraWidget1; // Optional extra widget 1
  final Widget? extraWidget2; // Optional extra widget 2

  const FilterSheetLayout({
    Key? key,
    required this.closeFiltersInkwell,
    required this.sortByExpansionTile,
     this.checkBoxListTile,
    required this.bottomRowStreamBuilder,
    this.extraWidget1,
    this.extraWidget2,
  }) : super(key: key);

  @override
  State<FilterSheetLayout> createState() => FilterSheetLayoutState();
}

class FilterSheetLayoutState extends State<FilterSheetLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        // Container containing filter elements and buttons
        child: Column(
          children: [
            // Header row with close button and "Filters" label
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.closeFiltersInkwell, // Close button
                  const SizedBox(width: 5),
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            // ListView for filter options and extra widgets
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.vertical)) *
                  0.77,
              child: ListView(
                children: [
                  widget.sortByExpansionTile, // Sorting options
                  widget.checkBoxListTile ?? const Row(), // Checkboxes and filters
                  widget.extraWidget1 ?? const Row(), // Optional extra widget 1
                  widget.extraWidget2 ?? const Row(), // Optional extra widget 2
                ],
              ),
            ),
             widget
                .bottomRowStreamBuilder, // Bottom row, possibly generated dynamically
          ],
        ),
      ),
    );
  }
}
