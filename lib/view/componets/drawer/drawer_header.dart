import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';


class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({
    super.key,
    required this.context,
     this.user,
  });

  final BuildContext context;
  final User? user;

  @override
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            //push to the users view page
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => AddUserPage(
            //             user: user,
            //             loggedUser: user,
            //             crudOperation: 'isView')));
          },
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                // user.imageUrl == null
                //     ? 
                    const CircleAvatar(
                        radius: 52,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 40,
                        ),
                      ),
                    // :
                    //  CircleAvatar(
                    //     radius: 52,
                    //     backgroundImage: CachedNetworkImageProvider(
                    //         user.imageUrl ?? '') //some default image propably
                    //     ),
                const SizedBox(height: 12),
                Text(user!.name ,
                    style: const TextStyle(fontSize: 28, color: Colors.white)),
                Text(user!.email,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        ),
      );
}
