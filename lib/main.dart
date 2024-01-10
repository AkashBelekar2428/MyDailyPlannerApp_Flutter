
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime _selectedDay = DateTime.now();
    Map<DateTime, List<dynamic>> _events = {};

    TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          TableCalendar(focusedDay:_focusedDay ,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format){
            setState(() {
              _calendarFormat = format;
            });
            },
            onDaySelected: (selected, focusDay){
            setState(() {
              _selectedDay = selected;
              _focusedDay = focusDay;
            });
            },
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
            selectedDayPredicate: (day){
            return isSameDay (_selectedDay,day);
            },
            eventLoader: (day){
            return _events[day] ?? [];
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child:SingleChildScrollView(
                child: Column(
                  children: [
                    ...?_events[_selectedDay]?.map((event) => ListTile(
                      title: Text(event),
                      trailing: IconButton(
                        icon: Icon(Icons.delete), onPressed: () {
                          setState(() {
                            _events[_selectedDay]?.remove(event);
                          });
                      },
                      ),
                    )) ?? [],
                    SizedBox(
                      height: 20,
                    ),
                    Text('Add Event:'),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _eventController,
                      decoration: InputDecoration(
                        hintText: 'Enter Event',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            final event = _eventController.text.toString();
                            if (event.isNotEmpty){
                              _events[_selectedDay] ??= [];
                              _events[_selectedDay]!.add(event);
                              _eventController.clear();
                            }
                          });
                        },
                        child: Text('Add Event'))
                  ],
                ),
              )
          )
        ],
      )
      );
   }
  }

