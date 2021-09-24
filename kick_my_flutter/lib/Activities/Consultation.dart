import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/CustomDrawer.dart';
import 'package:kick_my_flutter/Models/Task.dart';
import 'package:kick_my_flutter/lib_http.dart';
import 'package:kick_my_flutter/transfer.dart';
import '../_textfield.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class Consultation extends StatefulWidget {
  final int id;

  Consultation({Key? key,  required this.id}) : super(key: key);

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {

  // TODO: ask joris about state building while object is null throwing. Error: Null check operator used on a null value for flutter. Meanwhile, we fixed it by using a loader that only load when the httprequest is done , otherwise loading effect.

  // TODO: Turned slider into a function that returns a Widget So I could use it, otherwise... Error:  The instance member '_taskDetailResponse' can't be accessed in an initializer.
    bool _isLoading = false;
   bool _showToolTip = true;
   TaskDetailResponse? _taskDetailResponse ;

  void _getTaskDetail(int id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      this._taskDetailResponse = await getTaskDetail(id);
      print(_taskDetailResponse.toString());
    } on DioError catch (e) {
      print(e.response);
      print(e.message);

    }
    setState(() {
      _isLoading = false;
    });
  }


  @override
  void initState() {
    _getTaskDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
        ),
        body:
        _isLoading?SpinKitThreeBounce(
          color: Colors.redAccent,
          size: 40,
        ) :
        Container(

      //    color: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),

          child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Consultation",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        color: Colors.redAccent),
                  ),
                  MyTextField(
                    initialvalue: this._taskDetailResponse!.name,
                    label: "Title",
                    enabled: false,
                    icon: Icon(FontAwesomeIcons.tasks),
                  ),
                  MyTextField(
                    initialvalue: this._taskDetailResponse!.deadLine.toString(),
                    label: "Date",
                    enabled: false,
                    icon: Icon(FontAwesomeIcons.calendarCheck),
                  ),
                  Column(
                    children: [
                      Container(

                        height: 20,
                        child: Text("Pourcentage de temps écoulé"),
                        alignment: Alignment.bottomLeft,
                      ),
                      Container(

                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            value: this._taskDetailResponse!.percentageTimeSpent!.toDouble()/100, //task.percentageTimeSpent!.toDouble(),
                            valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),


                  // TODO : TOOL TIP + PROGRESS
                  Container(
                  margin: EdgeInsets.only(bottom: 1),
                   //color: Colors.yellow,
                    child: _ProgressBody(),
                  ),
                  Container(alignment: Alignment.bottomCenter,
                    //color: Colors.blue ,
                    child:   ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
                          backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.redAccent)),
                      onPressed: () {},
                      child: Text(
                        "SAVE",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),)
                  //color: Colors.green,
                ],
              ),

              


        ),
      );
  }

  Widget _ProgressBody() {
    if (!_showToolTip) {
      return Column(
        children: [
          Text("Progression de la tâche"),
          slider(),
        ],
      );
    } else
      return Row(
        children: [
          Column(
            children: [
              Text("Progression de la tâche"),
              SimpleTooltip(
                child: slider(),
                tooltipDirection: TooltipDirection.right,
                borderColor: Colors.white70,
                ballonPadding: const EdgeInsets.symmetric(vertical: 8),
                animationDuration: Duration(milliseconds: 100),
                hideOnTooltipTap: true,
                content: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Slide to change the progression",
                      style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Colors.blueGrey),
                    )),
                  ],
                ),
                show: true,
                tooltipTap: () {
                  setState(() {
                    _showToolTip = false;
                  });
                },
              )
            ],
          ),
        ],
      );
  }

  Widget slider() { return SleekCircularSlider(
      initialValue: _taskDetailResponse!.percentageDone!.toDouble(),
      appearance: CircularSliderAppearance(

          size: 130,
          customColors: CustomSliderColors(

            progressBarColor: Colors.redAccent,
            dotColor: Colors.white,
            trackColor: Colors.redAccent,
          ),
          infoProperties: InfoProperties(

              mainLabelStyle: TextStyle(color: Colors.black, fontSize: 28))),
      min: 0,
      max: 100,
      onChange: (double value) {});}
}
