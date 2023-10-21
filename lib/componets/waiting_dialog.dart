import 'package:flutter/material.dart';

// loading indicator dialog for DB operations and other....
waitingDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
            onWillPop: () async => true,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ));
}
