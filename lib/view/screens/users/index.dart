import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class UserIndex extends StatefulWidget {
  const UserIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<UserIndex> createState() => _UserIndexState();
}

class _UserIndexState extends State<UserIndex> {
     TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController nameController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      drawer: MyNavigationDrawer(
        user: widget.user,
      ),
      withFloatingButtons: true,
      bodyWidget: const Center(
        child: Text("USERS PAGEEEE!!!"),
      ),
      user: widget.user,
      withCrudButton: true,
      crudButton: () {
        showUserBottomSheet(context);
      },
    );
  }

  void showUserBottomSheet(BuildContext context) {
 
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Email TextField
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 16.0),
                    // Password TextField
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Κωδικός'),
                    ),
                    const SizedBox(height: 16.0),
                    // Username TextField
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: 'Όνομα Χρηστη'),
                    ),
                    const SizedBox(height: 16.0),
                    // Name TextField
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Όνομα'),
                    ),
                    const SizedBox(height: 16.0),
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        // Handle the form submission
                        String email = emailController.text;
                        String password = passwordController.text;
                        String username = usernameController.text;
                        String name = nameController.text;

                        // Create a User instance with the entered data
                        User newUser = User(
                          email: email,
                          password: password,
                          username: username,
                          name: name,
                        );

                        // Perform the necessary actions with the new user data
                        // For example, you might want to save the data to your database

                        // Close the bottom sheet
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
