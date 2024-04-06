import 'package:flutter/material.dart';

// loading indicator dialog for DB operations and other....
waitingDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
            canPop: false,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary),
              ),
            ),
          ));
}
