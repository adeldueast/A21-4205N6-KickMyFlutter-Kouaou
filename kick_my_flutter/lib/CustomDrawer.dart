import 'package:flutter/material.dart';
import 'package:kick_my_flutter/Models/SessionSingleton.dart';
import 'package:kick_my_flutter/lib_http.dart';

import 'Activities/AddTask.dart';

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
                  accountName:
                      Text(SessionSingleton.shared.username.toString()),
                  accountEmail: Text(
                      SessionSingleton.shared.username.toString() +
                          "@gmail.com"),
                  currentAccountPicture: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")),
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  selected: ModalRoute.of(context)!.settings.name == "/screen2",
                  onTap: () => {
                        selectDestination(0),
                        if (ModalRoute.of(context)!.settings.name == "/screen2")
                          {
                            Navigator.of(context).pop(),
                          }
                        else
                          {
                            Navigator.of(context).pop(),
                            Navigator.of(context)
                                .pushReplacementNamed("/screen2"),
                          }
                      }),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add task'),
                selected: ModalRoute.of(context)!.settings.name == "/screen3",
                onTap: () => {
                  selectDestination(1),
                  if (ModalRoute.of(context)!.settings.name == "/screen3")
                    {
                      Navigator.of(context).pop(),
                    }
                  else
                    {
                      //pop the drawer
                      Navigator.of(context).pop(),

                      if (ModalRoute.of(context)!.settings.name == "/screen4")
                        {Navigator.pushReplacementNamed(context, "/screen3")}
                      else
                        {Navigator.pushNamed(context, "/screen3")}
                    }
                },
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Log out'),
                selected: _selectedDestination == 2,
                onTap: () => {
                  selectDestination(2),
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/screen1', (Route<dynamic> route) => false),
                  logout(),
                },
              ),
            ],
          ),
        ));
  }
}
