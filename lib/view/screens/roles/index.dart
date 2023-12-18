import 'package:flutter/material.dart';
import 'package:museum_app/models/role.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/componets/drawer/drawer.dart';
import 'package:museum_app/view/layouts/base_layout.dart';

class RoleIndex extends StatefulWidget {
  const RoleIndex({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  State<RoleIndex> createState() => _RoleIndexState();
}

class _RoleIndexState extends State<RoleIndex> {
  TextEditingController titleController = TextEditingController();
  TextEditingController hierarchyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        drawer: MyNavigationDrawer(
          user: widget.user,
        ),
        user: widget.user,
        withFloatingButtons: true,
        withCrudButton: true,
        crudButton: () {
          showBottomRoleSheet(context);
        },
        bodyWidget: FutureBuilder(
            future: getRoles(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Role> roles = snapshot.data!;
                return Container(
                  margin: const EdgeInsets.only(top: 130, bottom: 10),
                  child: ListView.builder(
                      itemCount: roles.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(roles[index].title),
                          subtitle:
                              Text("hierarchy: ${roles[index].hierarchy}"),
                          trailing: GestureDetector(
                              onTap: () {
                                titleController.text = roles[index].title;
                                hierarchyController.text =
                                    roles[index].hierarchy.toString();
                                showBottomRoleSheet(context);
                              },
                              child: const Icon(Icons.edit)),
                        );
                      }),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error fetching Roles from database."),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<Role>> getRoles() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Role(title: 'static Developer', hierarchy: 0),
      Role(title: 'static Admin', hierarchy: 100),
      Role(title: 'static User', hierarchy: 200),
    ];
  }

  void showBottomRoleSheet(BuildContext context) {
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
                    // Title TextField
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Tίτλος'),
                    ),
                    const SizedBox(height: 16.0),
                    // Hierarchy TextField
                    TextField(
                      controller: hierarchyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Ιεραρχία (Αριθμός)'),
                    ),
                    const SizedBox(height: 16.0),
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        // Handle the form submission
                        String title = titleController.text;
                        int hierarchy =
                            int.tryParse(hierarchyController.text) ?? 0;

                        Role(title: title, hierarchy: hierarchy);

                        // Perform the necessary actions with title and hierarchy
                        // For example, you might want to save the data to your database

                        // Close the bottom sheet
                        Navigator.pop(context);
                      },
                      child: const Text('Αποθήκευση'),
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
