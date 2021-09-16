import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kick_my_flutter/Models/Task.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/lib_http.dart';
import 'package:kick_my_flutter/transfer.dart';

//TODO : difference entre Dio et simple http?
//TODO : 403 DioErrorType http 403?
//TODO : how am i suppose to initialize variables? null? Ex Date line 34 && 79; Or in constructor of Task

// ACCEUIL PAGE
class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  List<Task> _listeTask = new List<Task>.generate(
      20,
      (index) => new Task("Task " + index.toString(), ((index * 5) + 5) / 100,
          0.4, new DateTime.now()));

  Widget _addTaskButton(
    String newTaskName,
    DateTime newTaskDate,
    String newTaskDateText,
  ) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.redAccent,
      onPressed: () {
        Task newTask = Task(newTaskName, 0, 0, newTaskDate);
        print(newTask.toString());
        if (newTaskDate == null ||
            newTaskName.isEmpty ||
            newTaskDateText.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Make sure you pickedd a name anda  date")));
        } else {
          print("creating new task named --->>" + newTaskName);

          AddTaskRequest req = AddTaskRequest();
          req.name = newTaskName;
          req.deadline = newTaskDate;

          try {
            addTask(req);
          } on DioError catch (e) {
            print(e.response!.statusMessage);
            print(e.response!.statusCode);
          }
          Map<int, String> map;
          _listeTask.add(newTask);
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Text("Add task",
          style: TextStyle(
              fontSize: 34,
              color: Colors.white,
              decoration: TextDecoration.underline)),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
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
  }

  void _showModalBottomSheet() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        title: Center(child: Text("Home")),
      ),
      body: Container(
        color: Colors.white,
        child: new AcceuilBody(_listeTask),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: _showModalBottomSheet,
        child: Icon(
          Icons.add,
          size: 42,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
       // clipBehavior:Clip.antiAliasWithSaveLayer,
        notchMargin: 4.0,
        child: Container(height: 40,),
      ),
    );
  }
}

class AcceuilBody extends StatelessWidget {
  AcceuilBody(this._listeTask);

  final List<Task> _listeTask;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
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
                      Navigator.of(context).pushNamed(
                        "/screen3",
                      );
                    },
                    child: new TaskRow(_listeTask[index])),
                childCount: _listeTask.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskRow extends StatelessWidget {
  final Task task;

  TaskRow(this.task);

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
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
            task.nom,
            style: headerTextStyle,
          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0),
          ),
          //new Container(height: 9.0),
          new Text(task.dateLimite.toString(), style: subHeaderTextStyle),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: LinearProgressIndicator(
                    value: task.pourcentageDate,
                    valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                    backgroundColor: Colors.white,
                  ),
                  color: Colors.purple,
                ),
                flex: 1,
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                    backgroundColor: Colors.white,
                    value: task.pourcentageTask,
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
            color: Colors.redAccent,
          ),
          child: Icon(
            FontAwesomeIcons.list,
            size: 40,
            color: Colors.white,
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
