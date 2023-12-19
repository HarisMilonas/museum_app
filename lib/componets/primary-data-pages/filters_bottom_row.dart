import 'package:flutter/material.dart';

class BottomRow extends StatefulWidget {
  final void Function()? onTapClear;

  final int results;

  const BottomRow(
      {Key? key, required this.onTapClear,  required this.results})
      : super(key: key);

  @override
  State<BottomRow> createState() => BottomRowState();
}

class BottomRowState extends State<BottomRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.onTapClear,
            //  () {
            //   // if he hits clear go back to the default value
            //   setState(() {
            //     sortByval = 'category';
            //     permissionCategories = [];
            //   });
            // },
            child: Text(
              "clear",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
          ),
          TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              onPressed: () {
                // dont do anything i have updated the values
                Navigator.pop(context);
              },
              // we wrap the text with a StrreamBuilder and use the same stream as the main page because we want to monitor the results everytime
              child: Text("${widget.results.toString()} results")

              // Text("${results.toString()} results")
              )
        ],
      ),
    );
  }
}
