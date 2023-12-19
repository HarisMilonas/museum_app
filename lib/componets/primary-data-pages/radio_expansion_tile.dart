import 'package:flutter/material.dart';

class RadioExpansionTile extends StatefulWidget {
  const RadioExpansionTile(
      {Key? key,
      required this.sortByVal,
      required this.tileExpanded,
      required this.groupItems,
      
      required this.onChanged
      })
      : super(key: key);
  final String sortByVal;
  final bool tileExpanded;
  final List<String> groupItems;
  
  final void Function(String?)? onChanged;
  @override
  State<RadioExpansionTile> createState() => RadioExpansionTileState();
}

class RadioExpansionTileState extends State<RadioExpansionTile> {
  bool tileExpanded =
      false; // Local state variable to track the expansion state of the tile

  @override
  void initState() {
    tileExpanded = widget
        .tileExpanded; // Initialize the local state with the provided value
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Sort By",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          widget.sortByVal,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: Icon(
          tileExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        ),
        onExpansionChanged: (value) {
          setState(() {
            tileExpanded = value;
          });
        },
        children: widget.groupItems
            .map((field) => RadioListTile(
                  title: Text(field),
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: field,
                  groupValue: widget.sortByVal,
                  onChanged:  widget.onChanged,
                  // (value) {
                  //   setState(() {
                  //     sortByval = value!;
                  //   });
                  // },
                ))
            .toList());
  }
}
