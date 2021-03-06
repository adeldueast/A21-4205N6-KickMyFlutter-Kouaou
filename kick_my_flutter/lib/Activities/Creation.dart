import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/CustomWidgets/Custom_Drawer.dart';
import 'package:kick_my_flutter/Models/transfer.dart';
import 'package:kick_my_flutter/i18n/intl_localization.dart';
import '../CustomWidgets/Custom_Textfield.dart';
import '../Services/lib_http.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  DateTime? newTaskDate;
  String newTaskName = "";
  String newTaskDateText = "";
   bool isLoading =false;
  setLoading(bool state) => setState(() => isLoading = state);

  Future<DateTime?> _selectDate(BuildContext context) async {
    /*FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 90));*/

    DateTime? newDateTime = await showRoundedDatePicker(
        context: context,
        theme: ThemeData(
          primaryColor: Colors.redAccent[100],
          accentColor: Colors.redAccent,
          textTheme: TextTheme(button: TextStyle(color: Colors.redAccent)),
        ),
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        fontFamily: 'Poppins');

    return newDateTime;
  }

  _updateTaskName(String p1) {
    newTaskName = p1;
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding Title with --> " + newTaskName);
    print("rebuilding Date with --> " + newTaskDateText);

    return GestureDetector(
      onTap: () {
        //Permet de fermer le keyboard lorsqu'on clique ailleurs du TextField
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          drawer: MyCustomDrawer(),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.redAccent,
          ),
          body: Column(
            children: [
              Container(
                height: 300,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: Colors.redAccent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Locs.of(context).trans('create_task'),
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                    MyCustomTextField(
                      initialvalue: newTaskName,
                      onChange: _updateTaskName,
                      enabled: true,
                      label: Locs.of(context).trans("title"),
                      icon: Icon(FontAwesomeIcons.tasks),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyCustomTextField(
                            initialvalue: newTaskDateText,
                            enabled: false,
                            label: "Date",
                            icon: null,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 30),
                            padding: EdgeInsets.only(top: 23),
                            child: IconButton(
                              onPressed: () async {
                                //Permet de fermer le keyboard lorsqu'on clique ailleurs du TextField
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                newTaskDate = await _selectDate(context);

                                final DateFormat formatter =
                                    DateFormat.yMMMMd('en_US');

                                if (newTaskDate != null)
                                  newTaskDateText =
                                      formatter.format(newTaskDate!);
                                else
                                  newTaskDateText = "";

                                print("before setState Title : " + newTaskName);
                                print("before setState Date : " +
                                    newTaskDateText);

                                setState(() {});
                              },
                              icon: Icon(FontAwesomeIcons.calendarAlt),
                              iconSize: 40,
                              color: Colors.white,
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(23))),
                      primary: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 17),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  child: Text(Locs.of(context).trans("add_+")),
                  onPressed: isLoading ? null : ()=> _toggleButton(),
                ),
              ))
            ],
          )),
    );
  }


  _toggleButton() async{
    try {
      setLoading(true);
      await _addTask();
    } finally {
      setLoading(false);
    }
  }

  _addTask() async{
    if (newTaskName.isEmpty ||
        newTaskDate == null ||
        newTaskName == "")
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              Locs.of(context).trans("invalid_create_task"))));
    else {
      try {
        AddTaskRequest req = AddTaskRequest();
        req.name = newTaskName;
        req.deadLine = newTaskDate!;
        print(req.name);
        print(req.deadLine);
        await addTask(req);
        Navigator.pushReplacementNamed(context, "/screen2");
      } on DioError catch (e) {
        print(e.response!.statusMessage);
        print(e.response!.statusCode);
        if(e.response!.statusCode ==400){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  Locs.of(context).trans("invalid_create_task_alreadyExist"))));
        }
      }
    }

  }
}
