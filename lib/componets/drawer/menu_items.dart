import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/view/screens/email_page.dart';
import 'package:museum_app/view/screens/roles/index.dart';
import 'package:museum_app/view/screens/users/index.dart';

class MyMenuItems extends StatefulWidget {
  const MyMenuItems({
    required this.user,
    super.key,
    required this.context,
  });

  final User? user;

  final BuildContext context;

  @override
  State<MyMenuItems> createState() => _MyMenuItemsState();
}

class _MyMenuItemsState extends State<MyMenuItems> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .popUntil((route) => route.settings.name== 'HomePage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email Sender'),
            onTap: () {
              Navigator.pop(context);
               Navigator.of(context)
                      .popUntil((route) => route.settings.name == 'HomePage');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailPage(user: widget.user)));
            },
          ),
          ExpansionTile(
            title: const Text('Primary Data'),
            leading: const Icon(Icons.view_in_ar),
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            children: [
              // PermissionAccess.canView(widget.user, 'list-users')
              //     ?
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Users'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .popUntil((route) => route.settings.name == 'HomePage');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserIndex(user: widget.user)));
                },
              ),
              // : const Row(),
              // PermissionAccess.canView(widget.user, 'list-businesses')
              //     ? ListTile(
              //         leading: const Icon(Icons.business_center),
              //         title: const Text('Business'),
              //         onTap: () {
              //           Navigator.of(context).pop();
              //           Navigator.of(context)
              //               .popUntil((route) => route.isFirst);
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       BusinessPage(user: widget.user)));
              //         },
              //       )
              //     : const Row(),

              // PermissionAccess.canView(widget.user, 'list-roles')
              //     ?
              ListTile(
                leading: const Icon(Icons.supervisor_account),
                title: const Text('Roles'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .popUntil((route) => route.settings.name == 'HomePage');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoleIndex(user: widget.user)));
                },
              )
              // : const Row(),
              //     PermissionAccess.canView(widget.user, 'list-permissions')
              //         ? ListTile(
              //             leading: const Icon(Icons.pan_tool),
              //             title: const Text('Permissions'),
              //             onTap: () {
              //               Navigator.of(context).pop();
              //               Navigator.of(context)
              //                   .popUntil((route) => route.isFirst);
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) =>
              //                           PermissionPage(user: widget.user)));
              //             },
              //           )
              //         : const Row(),
              //   ],
              // ),
              // PermissionAccess.canView(widget.user, 'list-accounting') ||
              //         PermissionAccess.canView(widget.user, 'view-accounting')
              //     ? ListTile(
              //         leading: const Icon(Icons.supervisor_account),
              //         title: const Text('Accounting'),
              //         onTap: () {
              //           Navigator.of(context).pop();
              //           Navigator.of(context).popUntil((route) => route.isFirst);
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       AccountingPage(user: widget.user)));
              //         },
              //       )
              //     : const Row(),
              // ListTile(
              //   leading: const Icon(Icons.logout),
              //   title: const Text('Logout'),
              //   onTap: () {
              //     Navigator.of(context).popUntil((route) => route.isFirst);
              //     Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) => const LoginPage()));
              //   },
              // )
            ],
          ),
        ],
      ));
}
