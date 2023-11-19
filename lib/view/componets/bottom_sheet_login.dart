import 'package:flutter/material.dart';
import 'package:museum_app/componets/miscellanious.dart';
import 'package:museum_app/componets/validators.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "username",
                    border: InputBorder.none,
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                validator: CustomValidators.standardValidator,
                onSaved: (newValue) {
                  email = newValue!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "password",
                    border: InputBorder.none,
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                validator: CustomValidators.passwordValidator,
                obscureText: true,
                onSaved: (newValue) {
                  email = newValue!;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
