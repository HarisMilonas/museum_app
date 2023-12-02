import 'package:flutter/material.dart';

class CustomSnackBar {
  static successMessage(
      BuildContext context, String message, void Function()? onTap) {
    ScaffoldMessenger.of(context).clearSnackBars();


    return
    context.mounted ? null 
    :
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 85,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Success",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
              InkWell(
                onTap: onTap,
                child: onTap == null
                    ? const SizedBox()
                    : const Text(
                        "UNDO",
                      ),
              )
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.transparent,
        elevation: 3,
      ),
    );
  }

  static errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    return 
      !context.mounted ? null 
      : ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 85,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 89, 88),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              const Icon(
                Icons.cancel,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("An Error Occured",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.transparent,
        elevation: 3,
      ),
    );
  }
}
