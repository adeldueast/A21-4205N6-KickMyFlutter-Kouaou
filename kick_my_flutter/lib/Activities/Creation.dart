import 'package:flutter/material.dart';

class Creation extends StatefulWidget {
  const Creation({Key? key}) : super(key: key);

  @override
  _CreationState createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    final _createTaskButton = FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      color: Colors.redAccent[100],
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create a task",
            style: headerTextStyle,
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          title: Center(child: Text("Creation"))),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [

            _createTaskButton,
          ],
        ),
      ),
    );
  }
}
