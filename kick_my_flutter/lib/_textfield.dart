import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon? icon;
  final bool enabled;
  String? initialvalue;
  final Function(String)? onChange;

  MyTextField(
      {required this.label,
        this.maxLines = 1,
        this.minLines = 1,
        this.icon,
        required this.enabled,
        this.initialvalue,
        this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      enabled: this.enabled,
      controller: TextEditingController()..text = this.initialvalue ?? "",
      onChanged: (text) {


        onChange!(text);


      },
      style: TextStyle(color: Colors.black),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null : icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}