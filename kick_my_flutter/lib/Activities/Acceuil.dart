import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kick_my_flutter/Models/Task.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';

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
  var _pickedDate = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController accountController = TextEditingController();

    final _addTaskTextField = Container(

        margin: EdgeInsets.fromLTRB(20, 30, 20, 18),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: accountController,
          decoration: InputDecoration(
            labelText: "Enter a task name",
            labelStyle: TextStyle(color: Colors.white),
            /* prefixIcon: Icon(
              Icons.add_task_rounded,
              color: Colors.white,
            ),*/
            suffixIcon: IconButton(
              onPressed: () async {
              setState(() {

              });
                // TODO : https://githubmemory.com/repo/vilisimo/sink/issues/1
                FocusScope.of(context).requestFocus(new FocusNode());
                await Future.delayed(Duration(milliseconds: 100));

                DateTime? newDateTime = await showRoundedDatePicker(
                    context: context,
                    theme: ThemeData(
                      primaryColor: Colors.redAccent[100],
                      accentColor: Colors.redAccent,
                      textTheme:
                          TextTheme(button: TextStyle(color: Colors.redAccent)),
                    ),
                    // imageHeader: AssetImage("assets/images/calendar_header.jpg"),
                    description:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    fontFamily: 'Poppins'
                );

                if (newDateTime != null) {
                  final DateFormat formatter = DateFormat.yMMMMd('en_US');
                  final String formatted = formatter.format(newDateTime!);
                  print(formatted); // something like 2013-04-20
                  _pickedDate = formatted;
                }

              },
              icon: Icon(FontAwesomeIcons.calendarAlt),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
              borderSide: BorderSide(color: Colors.white, width: 4),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
              borderSide: BorderSide(color: Colors.white, width: 4),
            ),
            //hintText: "Enter task name",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        title: Center(child: Text("Acceuil")),
      ),
      body: Container(
        color: Colors.white,
        child: new Column(
          children: [
            new AcceuilBody(_listeTask),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,

        onPressed: () => showModalBottomSheet(
          // TODO :scrolls above the keyboard when keyboard is open
        isScrollControlled: true,
            context: context,
            builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter _AcceuilState){

                return Padding(
                  padding: EdgeInsets.only(
                    // TODO :scrolls above the keyboard when keyboard is open
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    color: Colors.redAccent[100],
                    child: Column(
                      children: [
                        //  color: Colors.brown,
                        _addTaskTextField,
                        Container(
                          color: Colors.green,
                          height: 40,
                          // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Center(child: Text(_pickedDate)),
                        )
                      ],
                    ),
                  ),
                );
              });
            }),
        child: Icon(
          Icons.add,
          size: 42,
        ),
      ),
    );
  }
}

class AcceuilBody extends StatelessWidget {
  AcceuilBody(this._listeTask);

  final List<Task> _listeTask;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        color: Colors.white,
        //color: new Color(0xFF736AB7),
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
                          "/screen4",
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
