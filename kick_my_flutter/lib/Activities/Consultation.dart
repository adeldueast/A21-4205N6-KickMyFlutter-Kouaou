import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/CustomDrawer.dart';
import '../_textfield.dart';

class Consultation extends StatelessWidget {
   Consultation({Key? key}) : super(key: key);


  DateTime? newTaskDate;
  String newTaskName = "";
  String newTaskDateText = "";

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
            MyTextField(label: "Title", enabled: false,icon: Icon(FontAwesomeIcons.tasks),),

            Container(height: 25,),

            MyTextField(label: "Date", enabled: false,icon: Icon(FontAwesomeIcons.calendarCheck),),


            Container(height: 50,child: Text("Pourcentage de temps écoulé"),alignment: Alignment.bottomLeft,),

            Container(


              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: 0.7,//task.percentageTimeSpent!.toDouble(),
                  valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
