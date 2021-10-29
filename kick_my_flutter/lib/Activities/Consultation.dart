import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kick_my_flutter/CustomWidgets/Custom_Drawer.dart';
import 'package:kick_my_flutter/Services/lib_http.dart';
import 'package:kick_my_flutter/Models/transfer.dart';
import 'package:kick_my_flutter/i18n/intl_localization.dart';
import '../CustomWidgets/Custom_Textfield.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class Consultation extends StatefulWidget {
  final int id;

  Consultation({Key? key, required this.id}) : super(key: key);

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  // TODO: ask joris about state building while object is null throwing. Error: Null check operator used on a null value for flutter. Meanwhile, we fixed it by using a loader that only load when the httprequest is done , otherwise loading effect.

  // TODO: Turned slider into a function that returns a Widget So I could use it, otherwise... Error:  The instance member '_taskDetailResponse' can't be accessed in an initializer.
  bool _isLoading = false;
  bool _showToolTip = true;
  TaskDetailResponse? _taskDetailResponse;

  late int _newProgressionTaskValue;
  XFile? pickedImage;
  String pickedImagePath = "";
  ImagePicker picker = new ImagePicker();

  void _getTaskDetail(int id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      this._taskDetailResponse = await getTaskDetail(id);
      _newProgressionTaskValue = _taskDetailResponse!.percentageDone;
      print(_taskDetailResponse.toString());
    } on DioError catch (e) {
      print(e.response);
      print(e.message);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _updateTaskDetails(int id, int valeur) async {
    try {
      if (pickedImage != null) {
        //debug purpose
        print(pickedImage!.name + " , " + pickedImage!.path);

        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(pickedImage!.path,
              filename: pickedImage!.name),
          "babyID": widget.id,
        });

        await addImageToTask(formData);
        NetworkImage("http://10.0.2.2:8080/file/baby/" +id.toString()+"?&width="+"100").evict();
      }
      await updateTaskPourcentage(id, valeur);

      //go back to acceuil
      Navigator.of(context).pushReplacementNamed("/screen2");
    } on DioError catch (e) {
      print(e.response);
      print(e.message);
    }
  }

  void _selectImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    pickedImagePath = pickedImage!.path;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getTaskDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyCustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: _isLoading
          ? SpinKitThreeBounce(
              color: Colors.redAccent,
              size: 40,
            )
          : Container(
              //    color: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Consultation",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        color: Colors.redAccent),
                  ),
                  MyCustomTextField(
                    initialvalue: this._taskDetailResponse!.name,
                    label: Locs.of(context).trans("title"),
                    enabled: false,
                    icon: Icon(FontAwesomeIcons.tasks),
                  ),
                  MyCustomTextField(
                    initialvalue: this._taskDetailResponse!.deadLine.toString(),
                    label: "Date",
                    enabled: false,
                    icon: Icon(FontAwesomeIcons.calendarCheck),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        height: 20,
                        child: Text(
                            Locs.of(context).trans("pourcentage_timeleft")),
                        alignment: Alignment.bottomLeft,
                      ),
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            value: this
                                    ._taskDetailResponse!
                                    .percentageTimeSpent
                                    .toDouble() /
                                100,
                            //task.percentageTimeSpent!.toDouble(),
                            valueColor:
                                AlwaysStoppedAnimation(Colors.redAccent),
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
                    child: _progressBody(),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: (pickedImage != null)
                          ? Container(
                              color: Colors.red,
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.file(
                                File(pickedImage!.path),
                                fit: BoxFit.contain,
                              ),
                            )
                          : DottedBorder(
                              child: Container(
                                width: double.infinity,
                                //  color: Colors.red,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => DottedBorder(
                                    child: Container(
                                      width: double.infinity,
                                      //  color: Colors.red,
                                      child: Center(
                                          child: Text(
                                            Locs.of(context).trans("no_image_selected"),
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    ),
                                  ),
                                  imageUrl:
                                  "http://10.0.2.2:8080/file/baby/" + widget.id.toString()+"?&width="+"100",width: 100, fit: BoxFit.contain,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        //color: Colors.blue ,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.redAccent)),
                          onPressed: _selectImage,
                          child: Text(
                            Locs.of(context).trans("select_image"),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        //color: Colors.blue ,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.redAccent)),
                          onPressed: () => _updateTaskDetails(
                              widget.id, _newProgressionTaskValue),
                          child: Text(
                            Locs.of(context).trans("save"),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  )
                  //color: Colors.green,
                ],
              ),
            ),
    );
  }

  Widget _progressBody() {
    if (!_showToolTip) {
      return Column(
        children: [
          Text(Locs.of(context).trans("progression_task")),
          slider(),
        ],
      );
    } else
      return Row(
        children: [
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(Locs.of(context).trans("progression_task"))),
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
                      Locs.of(context).trans("slide_tooltip"),
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

  Widget slider() {
    return SleekCircularSlider(
        initialValue: _taskDetailResponse!.percentageDone.toDouble(),
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
        onChange: (double value) {
          _newProgressionTaskValue = value.toInt();
        });
  }
}
