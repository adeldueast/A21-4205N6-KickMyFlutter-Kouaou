import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kick_my_flutter/CustomWidgets/Custom_Drawer.dart';
import 'package:kick_my_flutter/Services/lib_http.dart';
import 'package:kick_my_flutter/Models/transfer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kick_my_flutter/i18n/intl_localization.dart';

import 'Consultation.dart';

enum Status { loading, success, error, paused }

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
  String? _currentErrorMessage;
  late Status _status;

  Future<void> _httpGetListTask() async {
    setState(() {
      _status = Status.loading;
    });
    try {
      // afficher
      _listeTask = await getListTask();
      // arreter
      setState(() {
        _status = Status.success;
      });
    } on DioError catch (e) {
      // arreter
      setState(() {
        _status = Status.error;
        _currentErrorMessage = e.message;
      });
      print(e.response!.data);
    } on Error catch (e) {
      setState(() {
        _status = Status.error;
        _currentErrorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _httpGetListTask();
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
        //TODO: I18N
        title: Text(Locs.of(context).trans('home')),
      ),
      body: _status == Status.loading
          ? SpinKitThreeBounce(
              color: Colors.redAccent,
              size: 40,
            )
          : _status == Status.error
              ? RefreshIndicator(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text(_currentErrorMessage.toString()),
                      ),
                    ),
                  ),
                  onRefresh: _httpGetListTask)
              : _status == Status.success
                  ? AcceuilBody(_listeTask, () => _httpGetListTask())
                  : Container(),
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

class AcceuilBody extends StatefulWidget {
  AcceuilBody(
    this._listeTask,
    this.onRefresh,
  );

  final List<HomeItemResponse> _listeTask;
  final Function onRefresh;

  @override
  State<AcceuilBody> createState() => _AcceuilBodyState();
}

class _AcceuilBodyState extends State<AcceuilBody> {
  @override
  Widget build(BuildContext context) {
    return

           RefreshIndicator(
            onRefresh: () {

                return widget.onRefresh();

            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget._listeTask.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TaskRow(widget._listeTask[index]);
                },
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
                          value: task.percentageTimeSpent.toDouble() / 100,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ),
                    Align(
                      child: Text((task.percentageTimeSpent.toDouble() / 100)
                              .round()
                              .toString() +
                          " %"),
                      alignment: Alignment.topCenter,
                    ),
                  ],
                )),
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
        child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            //"http://10.0.2.2:8080/file/baby/"+task.id.toString()
            child: ClipOval(
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                  FontAwesomeIcons.list,
                  size: 40,
                  color: Colors.redAccent,
                ),
                imageUrl: "http://10.0.2.2:8080/file/baby/" +
                    task.id.toString() +
                    "?&width=" +
                    "100",
                width: 100,
                fit: BoxFit.cover,
              ),
            )));
    // new Image(
    // image: new AssetImage("assets/images/mars.png"),
    // height: 92.0,
    // width: 92.0,
    // ),

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
