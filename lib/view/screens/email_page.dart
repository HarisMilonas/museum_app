import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/api/newsletter.dart';
import 'package:museum_app/componets/snackbars.dart';
import 'package:museum_app/componets/validators.dart';
import 'package:museum_app/componets/waiting_dialog.dart';

import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String emailTo = '';

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      withFloatingButtons: true,
      user: widget.user,
      bodyWidget: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Σύνταξη νέου email για όλους τους εγγεγραμμένους χρήστες",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18),
                  ),
                ),
                TextFormField(
                  initialValue: 'museum.hmu@gmail.com',
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Λογαριασμός'),
                ),
                const SizedBox(height: 16),
                // TextFormField(
                //   decoration: const InputDecoration(labelText: 'Email To'),
                //   controller: toEmailController,
                //   validator: CustomValidators.emailValidator,
                // ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Θέμα'),
                  controller: subjectController,
                  validator: CustomValidators.standardValidator,
                ),
                const SizedBox(height: 26),
                TextFormField(
                  maxLines: 10,
                  controller: messageController,
                  validator: CustomValidators.standardValidator,
                  decoration: const InputDecoration(
                    labelText: 'Περιεχόμενο',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    waitingDialog(context);

                    List<String>? emails =
                        await NewsLetterApi().getNewsLetterEmails();

                    if (emails == null || emails == []) {
                      if (context.mounted) {
                        CustomSnackBar.errorMessage(
                            context, "Δεν βρέθηκαν εγγεγραμένοι χρήστες!");
                        Navigator.pop(context);
                        return;
                      }
                    }
                    for (String email in emails!) {
                      emailTo = email;

                      if (kDebugMode) {
                        print(
                          "Subject : ${subjectController.text} Message : ${messageController.text}  toEmail : $emailTo");
                      }

                      String message = await NewsLetterApi().sendEmail(
                          subjectController.text,
                          messageController.text,
                          emailTo);
                      if (context.mounted) {
                        Navigator.pop(context);
                        if (message.contains('Error')) {
                          CustomSnackBar.errorMessage(context, message);
                        } else {
                          CustomSnackBar.successMessage(context, message, null);
                        }
                      }
                    }
                  },
                  child: const Text('Send Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
