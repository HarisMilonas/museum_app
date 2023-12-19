import 'package:flutter/material.dart';
import 'package:museum_app/componets/dialogs/is_sure_dialog.dart';
import 'package:museum_app/componets/primary-data-pages/filters_bottom_row.dart';
import 'package:museum_app/componets/primary-data-pages/filters_sheet.dart';
import 'package:museum_app/componets/primary-data-pages/radio_expansion_tile.dart';
import 'package:museum_app/componets/primary-data-pages/search_bar.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class UserIndex extends StatefulWidget {
  const UserIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<UserIndex> createState() => _UserIndexState();
}

// lists for filters
List<String> groupItems = ['username', 'name', 'email'];

class _UserIndexState extends State<UserIndex> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  //filters
  String searchVal = '';
  final TextEditingController searchBarController = TextEditingController();
  String sortByval = 'username';

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      drawer: MyNavigationDrawer(
        user: widget.user,
      ),
      withFloatingButtons: true,
      bodyWidget: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> users = _runThroughFilters(snapshot.data!);
              
              if (searchVal.isNotEmpty) {
                users.removeWhere((element) => !element.name
                    .trim()
                    .toLowerCase()
                    .contains(searchVal..trim().toLowerCase()));
              }
              // roles.sort((a, b) => !isAscending
              //     ? a.hierarchy.compareTo(b.hierarchy)
              //     : b.hierarchy.compareTo(a.hierarchy));
              return Column(
                children: [
                  const SizedBox(height: 120),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addButton(context),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomSearchBarRow(
                              controller: searchBarController,
                              onChangedSearchBar: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    searchVal = value;
                                  });
                                } else {
                                  searchVal = '';
                                }
                              },
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchVal = '';
                                      searchBarController.text = '';
                                    });
                                  },
                                  child: searchVal.isEmpty
                                      ? const Icon(
                                          Icons.search,
                                          color:
                                              Color.fromARGB(181, 19, 18, 18),
                                        )
                                      : const Icon(
                                          Icons.cancel,
                                          color:
                                              Color.fromARGB(181, 19, 18, 18),
                                        )),
                              hintLabel: "ψάξε βάση ονόματος"),
                        ),
                        const SizedBox(width: 5),
                        filterChip(context, users),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return dissmissTile(context, users, index);
                          }),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error fetching Roles from database."),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      user: widget.user,
    );
  }

  InkWell addButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showUserBottomSheet(context, "Νέος Χρήστης");
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
    );
  }

  InkWell filterChip(BuildContext context, List<User> users) {
    return InkWell(
      onTap: () async {
        await _filterUsers(users);
        setState(() {});
      },
      child: Chip(
          side: BorderSide.none,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          label: const Text("filters")),
    );
  }

  Future<void> _filterUsers(List<User> users) async {
    bool fieldsTileExpanded = false;
    //implement it when we fix the roles table
    // bool categoryTileExpanded = true;

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        // because show modal sheet is not a stateful widget
        return StatefulBuilder(builder: (context, setState) {
          return FilterSheetLayout(
            closeFiltersInkwell: InkWell(
                onTap: () {
                  sortByval = 'username';
                  // userCategories = [];
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close)),
            sortByExpansionTile: RadioExpansionTile(
              sortByVal: sortByval,
              tileExpanded: fieldsTileExpanded,
              groupItems: groupItems,
              onChanged: (value) {
                setState(() {
                  sortByval = value!;
                });
              },
            ),
            bottomRowStreamBuilder: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: BottomRow(
                    onTapClear: () {
                      // if he hits clear go back to the default value
                      setState(() {
                        sortByval = 'username';
                        // userCategories = [];
                      });
                    },
                    results: users.length)),
          );
        });
      },
    );
  }

  Container dissmissTile(BuildContext context, List<User> users, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: ObjectKey(users[index]),
        background: Container(
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.orange,
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              size: 28,
            ),
          ),
          //  Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          setState(() {
            users.removeAt(index);
            //delete from db
          });
        },
        confirmDismiss: (DismissDirection direction) async {
          return await isSureDialog(context, 'user', users[index].name) ??
              false;
        },
        child: ListTile(
          title: Text(users[index].name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(users[index].username),
              const SizedBox(height: 3),
              Text(users[index].email),
            ],
          ),
          trailing: GestureDetector(
              onTap: () {
                usernameController.text = users[index].username;
                nameController.text = users[index].name;
                passwordController.text = users[index].password;
                emailController.text = users[index].email;
                showUserBottomSheet(
                    context, "Ανανέωση Στοιχείων ${users[index].name}");
              },
              child: const Icon(
                Icons.edit,
              )),
        ),
      ),
    );
  }

  void showUserBottomSheet(BuildContext context, String crud) {
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
                    Center(
                      child: Text(
                        crud,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                      decoration:
                          const InputDecoration(labelText: 'Όνομα Χρηστη'),
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

  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      User(
          email: "user1@example.com",
          password: '123456',
          username: "user1",
          name: "user one"),
      User(
          email: "user2@example.com",
          password: '123456',
          username: "user2",
          name: "user two"),
      User(
          email: "user3@example.com",
          password: '123456',
          username: "user3",
          name: "user three"),
      User(
          email: "user4@example.com",
          password: '123456',
          username: "user4",
          name: "user four"),
    ];
  }

  List<User> _runThroughFilters(List<User> users) {
    print(sortByval);
    // if (userCategories.isNotEmpty) {
    //   users
    //       .removeWhere((user) => !userCategories.contains(user.business.title));
    // }
    // if (sortByval == 'business') {
    //   users.sort((a, b) => a.business.title.compareTo(b.business.title));
    // }
    // if (sortByval == 'role') {
    //   users.sort((a, b) => a.role.hierarchy.compareTo(b.role.hierarchy));
    // }
    if (sortByval == 'name') {
      users.sort((a, b) => a.name.compareTo(b.name));
    }

    return users;
  }
}
