import 'dart:ui';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kick_my_flutter/CustomWidgets/Custom_Drawer.dart';
import 'package:kick_my_flutter/Models/Task.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/Services/lib_http.dart';
import 'package:kick_my_flutter/Models/transfer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Consultation.dart';

// ACCEUIL PAGE
class Acceuil extends StatefulWidget {
  const Acceuil({
    Key? key,
  }) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  List<HomeItemResponse> _listeTask = [];
  bool _isLoading = false;

  //TODO : Ancien button pour addtask dans le showmodalSheet
  /*Widget _addTaskButton(
    String newTaskName,
    DateTime newTaskDate,
    String newTaskDateText,
  ) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.redAccent,
      onPressed: () async {
        if (newTaskDate == null ||
            newTaskName.isEmpty ||
            newTaskDateText.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Make sure you picked a name and a  date")));
        } else {
          try {
            AddTaskRequest req = AddTaskRequest();
            req.name = newTaskName;
            req.deadline = newTaskDate;
            await addTask(req);
          } on DioError catch (e) {
            print(e.response!.statusMessage);
            print(e.response!.statusCode);
          }
          HTTPgetListTask();
          Navigator.pop(context);
          //setState(() {});
        }
      },
      child: Text("Add task",
          style: TextStyle(
              fontSize: 34,
              color: Colors.white,
              decoration: TextDecoration.underline)),
    );
  }*/
  //TODO : Ancien _showDatePicker pour addtask dans le showmodalSheet
  /*Future<DateTime?> _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 90));

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
    if (newDateTime != null) {
      final DateFormat formatter = DateFormat.yMMMMd('en_US');
      final String formatted = formatter.format(newDateTime);
      // print(formatted); // something like 2013-04-20

      return newDateTime;
    }
    return newDateTime;
  }*/
  //TODO : Ancien _showModalBottomSheet pour addtask dans le showmodalSheet
  /*void _showModalBottomSheet() {
    DateTime? newTaskDate = DateTime.now();
    late String newTaskName = "";
    late String newTaskDateText = "";
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                //Permet de fermer le keyboard lorsqu'on clique ailleurs du TextField
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                // TODO : BottomSheet reste par dessus le clavier sinon pas derreur mais il est caché derrière le keyboard
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                //BottomSheet Container
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.redAccent[100],
                    height: MediaQuery.of(context).size.height * 0.34,
                    child: Column(
                      children: [
                        // Title Create a task
                        Container(
                          child: _addTaskButton(
                              newTaskName, newTaskDate!, newTaskDateText),
                        ),
                        //ROW TextField & Calendar
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 19),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  onChanged: (text) {
                                    newTaskName = text;
                                    print("text changing ... task name " +
                                        newTaskName);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Task name',
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 5)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 5)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 19),
                                  padding: EdgeInsets.only(bottom: 14),
                                  child: IconButton(
                                    iconSize: 60,
                                    icon: Icon(FontAwesomeIcons.calendarCheck),
                                    color: Colors.white,
                                    onPressed: () async {
                                      newTaskDate =
                                          (await _selectDate(context))!;
                                      final DateFormat formatter =
                                          DateFormat.yMMMMd('en_US');
                                      final String formatted =
                                          formatter.format(newTaskDate!);
                                      newTaskDateText = formatted;

                                      print("new task --->>" +
                                          newTaskName +
                                          " " +
                                          formatted);
                                      state(() {});
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //Date : 20 September 2021

                        Container(
                          margin: EdgeInsets.only(left: 18),
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),

                          alignment: Alignment.centerLeft,
                          // color:Colors.blue,
                          child: Text("Date : " + newTaskDateText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ],
                    )),
              ),
            );
          });
        });
  }*/

  Future<void> HTTPgetListTask() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _listeTask = await getListTask();
      /*  for (var o in _listeTask) {
        print(o.toString());
      }*/
    } on DioError catch (e) {
      print(e.response!.data);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    HTTPgetListTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyCustomDrawer(),
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.redAccent),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text("Home"),
      ),
      body: _isLoading
          ? SpinKitThreeBounce(
              color: Colors.redAccent,
              size: 40,
            )
          : Container(
              color: Colors.white,
              child: new AcceuilBody(_listeTask, HTTPgetListTask),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => // Navigator.pushNamed(context, "/screen3"),
            //  _showModalBottomSheet(),
            Navigator.pushNamed(context, "/screen3"),
        child: Icon(
          Icons.add,
          size: 42,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Container(
          height: 36,
        ),
      ),
    );
  }
}

class AcceuilBody extends StatelessWidget {
  AcceuilBody(
    this._listeTask,
    this.onRefresh,
  );

  final List<HomeItemResponse> _listeTask;
  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: CustomRefreshIndicator(
        builder: (context, child, controller) {
          /// TODO: Implement your own refresh indicator
          return Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  /// This part will be rebuild on every controller change
                  return Container(
                    width: 0,
                    height: 0,
                  );
                },
              ),

              /// Scrollable widget that was provided as [child] argument
              ///
              /// TIP:
              /// You can also wrap [child] with [Transform] widget to also a animate list transform (see example app)
              child,
            ],
          );
        },
        onRefresh: () => onRefresh(),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              sliver: new SliverFixedExtentList(
                itemExtent: 152.0,
                delegate: new SliverChildBuilderDelegate(
                  (context, index) => GestureDetector(
                      onTap: () {
                        //Navigator.pushNamed(context, "/screen4", arguments: _listeTask[index].id!);
                        if (_listeTask[index].id != null)
                          Navigator.push(

                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Consultation(id: _listeTask[index].id),

                            ),
                          );
                      },
                      child: new TaskRow(_listeTask[index])),
                  childCount: _listeTask.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskRow extends StatelessWidget {
  final HomeItemResponse task;

  TaskRow(this.task);

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    final regularTextStyle = baseTextStyle.copyWith(
        // color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle =
        regularTextStyle.copyWith(fontSize: 12.0, color: Colors.white);

    final taskCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 8.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 1.0),
          new Text(
            task.name.toString(),
            style: headerTextStyle,
          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0),
          ),
          //new Container(height: 9.0),
          new Text(task.deadline.toString(), style: subHeaderTextStyle),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(

                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: LinearProgressIndicator(
                            value: task.percentageTimeSpent.toDouble()/100,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                      Align(child: Text((task.percentageTimeSpent.toDouble()/100).round().toString()+" %"), alignment: Alignment.topCenter,),
                    ],
                  )
                ),
                flex: 1,
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                    backgroundColor: Colors.white,
                    value: task.percentageDone.toDouble() / 100,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final taskThumbnail = new Container(
        margin: new EdgeInsets.symmetric(
          vertical: 0,
        ),
        alignment: FractionalOffset.centerLeft,
        child:
            // new Image(
            // image: new AssetImage("assets/images/mars.png"),
            // height: 92.0,
            // width: 92.0,
            // ),
            Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            FontAwesomeIcons.list,
            size: 40,
            color: Colors.redAccent,
          ),
        ));

    final taskCard = new Container(
      height: 140.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        // color: new Color(0xFF333366),
        color: Colors.redAccent[100],
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: taskCardContent,
    );

    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        children: [
          taskCard,
          taskThumbnail,
        ],
      ),
    );
  }
}
