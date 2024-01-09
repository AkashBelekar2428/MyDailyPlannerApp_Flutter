
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyDeailyPlannerApp());
}

class MyDeailyPlannerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyDeailyPlannerApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyDeailyPlannerScreen(),
    );
  }
}


class MyDeailyPlannerScreen extends StatefulWidget {
  @override
  State<MyDeailyPlannerScreen> createState() => MyDailyPlannerstate();
}
  class MyDailyPlannerstate extends State<MyDeailyPlannerScreen>{
  CrCalendarController _controller = CrCalendarController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body:  CrCalendar(controller: _controller,
          initialDate: DateTime.now(),
        backgroundColor: Colors.white,
      ),


      );

  }

}

