import 'package:flutter/material.dart';
import 'package:kick_my_flutter/Models/Session.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int _selectedDestination = 0;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(35)),
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.redAccent),
                  accountName: Text(Session.shared.username.toString()),
                  accountEmail:
                      Text(Session.shared.username.toString() + "@gmail.com"),
                  currentAccountPicture: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")),
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  selected: _selectedDestination == 0,
                  onTap: () => {
                        selectDestination(0),
                        if (ModalRoute.of(context)!.settings.name == "/screen2")
                          {
                            Navigator.of(context).pop(),
                          }
                        else
                          {}
                      }),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add task'),
                selected: _selectedDestination == 1,
                onTap: () => {selectDestination(1),
                  Navigator.pop(context),

                },
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Log out'),
                selected: _selectedDestination == 2,
                onTap: () => {
                  selectDestination(2),

                },
              ),
            ],
          ),
        ));
  }
}
