import 'package:flutter/material.dart';

Future<bool?> isSureDialog(
    BuildContext context, String type, String item) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: Text("Are you sure you wish to delete $type: $item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Delete")),
          ],
        );
      });
}
