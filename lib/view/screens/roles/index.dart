import 'package:flutter/material.dart';
import 'package:museum_app/componets/dialogs/is_sure_dialog.dart';
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
  bool isAscending = false;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        withFloatingButtons: true,
        drawer: MyNavigationDrawer(
          user: widget.user,
        ),
        user: widget.user,
        bodyWidget: FutureBuilder(
            future: getRoles(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Role> roles = snapshot.data!;
                roles.sort((a, b) => !isAscending
                    ? a.hierarchy.compareTo(b.hierarchy)
                    : b.hierarchy.compareTo(a.hierarchy));
                return Column(
                  children: [
                    const SizedBox(height: 120),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addButton(context),
                          filterChip(context),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListView.builder(
                            itemCount: roles.length,
                            itemBuilder: (context, index) {
                              return dissmissTile(context, roles, index);
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
            }));
  }

  InkWell addButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomRoleSheet(context , "Νέος Ρόλος");
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

  InkWell filterChip(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isAscending = !isAscending;
        });
      },
      child: Chip(
          side: BorderSide.none,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("hierarchy"),
              isAscending
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.keyboard_arrow_down)
            ],
          )),
    );
  }

  Container dissmissTile(BuildContext context, List<Role> roles, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: ObjectKey(roles[index]),
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
            roles.removeAt(index);
            //delete from db
          });
        },
        confirmDismiss: (DismissDirection direction) async {
         return await isSureDialog(context, 'role', roles[index].title) ?? false;
        },
        child: ListTile(
          title: Text(roles[index].title),
          subtitle: Text("hierarchy: ${roles[index].hierarchy}"),
          trailing: GestureDetector(
              onTap: () {
                titleController.text = roles[index].title;
                hierarchyController.text = roles[index].hierarchy.toString();
                showBottomRoleSheet(context , "Ανανέωση Στοιχείων ${roles[index].title}");
              },
              child: const Icon(
                Icons.edit,
              )),
        ),
      ),
    );
  }

  Future<List<Role>> getRoles() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Role(title: 'static Developer', hierarchy: 0),
      Role(title: 'static Admin', hierarchy: 100),
      Role(title: 'static User', hierarchy: 200),
    ];
  }

  void showBottomRoleSheet(BuildContext context , String crud) {
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
                      child: Text(crud , style: TextStyle(fontSize: 18 , color: Theme.of(context).colorScheme.primary),),
                    ),
                    const SizedBox(height: 16),
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
