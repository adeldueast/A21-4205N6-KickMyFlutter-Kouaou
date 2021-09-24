import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/CustomDrawer.dart';
import '../_textfield.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';


class Consultation extends StatefulWidget {
  Consultation({Key? key}) : super(key: key);

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  DateTime? newTaskDate;
  String newTaskName = "";
  String newTaskDateText = "";
  bool _showToolTip = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
        child: Column(
          children: [
            Text(
              "Consultation",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  color: Colors.redAccent),
            ),
            MyTextField(
              label: "Title",
              enabled: false,
              icon: Icon(FontAwesomeIcons.tasks),
            ),
            Container(
              height: 25,
            ),
            MyTextField(
              label: "Date",
              enabled: false,
              icon: Icon(FontAwesomeIcons.calendarCheck),
            ),
            Container(
              height: 50,
              child: Text("Pourcentage de temps écoulé"),
              alignment: Alignment.bottomLeft,
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: 0.7, //task.percentageTimeSpent!.toDouble(),
                  valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ),
            Container(height: 50,),

            // TODO : TOOL TIP + PROGRESS
            Container(
              child: _ProgressBody(),
            ),
              //color: Colors.green,



           ElevatedButton(


              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical:5,horizontal: 20)),
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.redAccent)

              ),
              onPressed: (){},
              child: Text("SAVE",style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w700),),
            ),

          ],
        ),
      ),
    );
  }

   Widget  _ProgressBody(){

    if(!_showToolTip){
      return Column(
        children: [
          Text("Progression de la tâche"),
          slider,


        ],
      );
    }
    else
      return Row(
        children: [

          Column(
            children: [
              Text("Progression de la tâche"),

              SimpleTooltip(
                child: slider,
                tooltipDirection: TooltipDirection.right,
                borderColor: Colors.white70,
                ballonPadding: const EdgeInsets.symmetric(vertical: 8),
                animationDuration: Duration(milliseconds: 100),
                hideOnTooltipTap:true,
                content: Row(
                  children: [
                    Expanded(child: Text("Slide to change the progression", style: TextStyle(fontSize: 12, decoration: TextDecoration.none , color: Colors.blueGrey ),)),
                  ],
                ),
                show: true,
                tooltipTap: (){

                  setState(() {
                    _showToolTip=false;
                  });
                },
              )

            ],
          ),

        ],
      );

  }
  final slider = SleekCircularSlider(

      appearance: CircularSliderAppearance(

        size: 130,
        customColors: CustomSliderColors(
          progressBarColor: Colors.redAccent,
          dotColor: Colors.white,
          trackColor: Colors.redAccent,
        ),
        infoProperties: InfoProperties(

          mainLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 28
          )
        )
      ),
      min: 0,
      max: 100,
      onChange: (double value){}
  );
}
