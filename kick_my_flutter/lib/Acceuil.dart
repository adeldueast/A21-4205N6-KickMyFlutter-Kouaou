import 'package:flutter/material.dart';

// ACCEUIL PAGE
class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Acceuil"),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Press me"))
          ],
        ),

    );
  }
}
