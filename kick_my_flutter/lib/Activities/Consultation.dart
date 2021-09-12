import 'package:flutter/material.dart';

class Consultation extends StatelessWidget {
  const Consultation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        title: Center(child: Text("Consultation")),
      ),
      body: Container(
        color: Colors.redAccent,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
