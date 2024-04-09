import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import './second.dart';
import './PlanSettingPage.dart';
import './PlanShow.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class Event {
  final String title;///final:変更できない変数
  final String? description;
  final DateTime dateTime;
  Event(///コンストラクタ
    {required this.title, this.description, required this.dateTime}
  );
}

class _HomeState extends State<Home> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<String> _selectedEvents = [];
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<Event> Events = [];
  Map<DateTime, List<String>> EventMap = {
    DateTime.utc(2024, 4, 13): ['firstevent', 'secondEvent'],
  };
  final Set<DateTime> selectedDays = <DateTime>{};
  final sampleMap = {
    DateTime.utc(2024, 3, 13): ['firstevent', 'secondEvent'],
    DateTime.utc(2024, 3, 20): ['thirdevent', 'fourseEvent'],
  };

  void openPlanSettingPage(Events,EventMap) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlanShow(selectedDays, Events, EventMap);
        }
      ),
    );
  }

  Map returnEventMap(Events,EventMap) {
    String t = "";
    for (var i in Events){
      t = i.title;
      if (t.runtimeType == String){
        EventMap[i.dateTime] = [t];
      }
    }
    return EventMap;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime.now();
              _selectedDay = null;
              selectedDays.clear();
            });
          },
        ),
      ),
      body: Column(children: [
        TableCalendar(
          focusedDay: _focusedDay, 
          rangeSelectionMode: _rangeSelectionMode,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          onRangeSelected: (start, end, focuseDay) {
            setState(() {
              _rangeStart = start;
              _rangeEnd = end;
            });
          },
          calendarFormat: _calendarFormat,
          locale: 'ja_JP',
          firstDay: DateTime(2000), 
          lastDay: DateTime(2050),
          eventLoader: (date) {
            return EventMap[date] ?? [];
          },
          selectedDayPredicate: (day){
            return isSameDay(_selectedDay, day);
          },
          onDaySelected:  (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _selectedEvents = EventMap[selectedDay] ?? [];
              _rangeStart = null;
              _rangeEnd = null;
              if (selectedDays.contains(selectedDay)){
                selectedDays.remove(selectedDay);
              }else{
                selectedDays.clear();

                selectedDays.add(selectedDay);
              }

            });
          },
          onFormatChanged: (format) {
            AlertDialog(
              title: Text("タイトル"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _selectedEvents.length,
            itemBuilder: ((context, index) {
              final event = _selectedEvents[index];
              return Card(
                child: ListTile(
                  title: Text(event),
                ),
              );
            }
            ),
          ),
        ),
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            openPlanSettingPage(Events,EventMap);
          });
          returnEventMap(Events,EventMap);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
        
  }

}