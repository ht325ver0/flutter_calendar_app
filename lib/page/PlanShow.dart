import 'package:flutter/material.dart';
import 'package:flutter_watch_application/page/home.dart';
import 'package:intl/intl.dart';
import './PlanSettingPage.dart';


class PlanShow extends StatelessWidget {
  
  Set<DateTime> selectedDays;
  Map<DateTime, List<String>> EventMap = {};
  List<Event> Events;
  DateTime date = DateTime.now();
  String titleDate = "";
  String day = "";
  String title = "";
  String content = "";
  List<String> selectdayevents = [];

  final _editController = TextEditingController();

  PlanShow(this.selectedDays, this.Events, this.EventMap);

  
  void changevar(selectedDays, EventMap){
    if (selectedDays.length == 1){
      date = selectedDays.elementAt(0);
    }///ここから
    selectdayevents = EventMap[date];
    
  }

  String createDateperiod(dates) {
    titleDate = "";
    for (int i = 0; i < dates.length; i++){
      day = DateFormat.Md().format(dates.elementAt(i));
      titleDate += day + ",";
    }
    titleDate = titleDate.substring(0, titleDate.length - 1);

    return titleDate;
  }

  List returnPgae(eventsList, title, content, selectedDays) {
    for (int i = 0; i < selectedDays.length; i++){
      eventsList.add(Event(
                  title: title,
                  description: content,
                  dateTime: selectedDays.elementAt(i),
                )
              );
    }
    return eventsList;
  }

  @override
  Widget build(BuildContext context) {
    
    changevar(selectedDays, EventMap);

    return MaterialApp(

      

    home: Scaffold(
      appBar: AppBar(
        title: Text(createDateperiod(selectedDays)),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: ()=>Navigator.pop(context, ),
        ),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return PlanSettingPage(selectedDays, Events);
              }),
            ),
            icon: Icon(Icons.add),
          ),
        ]
      ),
      body:Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: selectdayevents.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    title: Text(selectdayevents[index]),
                  ),
                );
              }),
              separatorBuilder: (context, index){
                return Divider(
                  color: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );}
}