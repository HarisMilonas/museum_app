import 'package:flutter/material.dart';
import 'package:museum_app/api/auth.dart';
import 'package:museum_app/componets/validators.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/screens/home.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool isLoading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Image(
                  image: AssetImage("images/logo.png"),
                  width: 160,
                  height: 70,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "username",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2)),
                  validator: CustomValidators.standardValidator,
                  onSaved: (newValue) {
                    username = newValue!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "password",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2)),
                  validator: CustomValidators.passwordValidator,
                  obscureText: true,
                  onFieldSubmitted: (value) => _signUserIn(),
                  onSaved: (newValue) {
                    password = newValue!;
                  },
                ),
                errorMessage.isNotEmpty
                    ? errorWidget()
                    : const SizedBox(height: 30),
                isLoading
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator())
                    : Container(),
                ElevatedButton(
                  onPressed: _signUserIn,
                  child: const Text('Είσοδος'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUserIn() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    formKey.currentState!.save();
    var authenticateResult =
        await AuthApi().getAuthenticatedUser(username, password, context);

    if (authenticateResult.containsKey("user") && mounted) {
      User user = authenticateResult["user"];
       Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(user: user)));
    } else {
      setState(() {
        errorMessage = authenticateResult['message'];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget errorWidget() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(8),
        height: 85,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 179, 89, 88),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            InkWell(
              onTap: () => setState(() {
                errorMessage = "";
              }),
              child: const Icon(
                Icons.cancel,
                color: Colors.white,
                size: 40,
              ),
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
                  errorMessage,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
          ],
        ),
      );
}
