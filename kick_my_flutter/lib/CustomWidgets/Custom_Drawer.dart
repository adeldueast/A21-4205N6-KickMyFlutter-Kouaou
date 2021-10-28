import 'package:flutter/material.dart';
import 'package:kick_my_flutter/Models/SessionSingleton.dart';
import 'package:kick_my_flutter/Services/lib_http.dart';
import 'package:kick_my_flutter/i18n/intl_localization.dart';

class MyCustomDrawer extends StatefulWidget {
  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
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
                  //TODO: i18n
                  title: Text("Locs.of(context).trans('home')"),

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
                            Navigator.of(context).pop(),

                          }
                      }),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Locs.of(context).trans('add_task')"),
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
