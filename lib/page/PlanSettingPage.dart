import 'package:flutter/material.dart';
import 'package:flutter_watch_application/page/home.dart';
import 'package:intl/intl.dart';

class PlanSettingPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ///final _scaffoldKey = Globalkey();

  
  Set<DateTime> selectedDays;
  List<Event> Events;
  String titleDate = "";
  String day = "";
  String title = "";
  String content = "";

  final _editController = TextEditingController();

  PlanSettingPage(this.selectedDays, this.Events);
  

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
    return MaterialApp(

    home: Scaffold(
      appBar: AppBar(
        title: Text(createDateperiod(selectedDays)),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: ()=>Navigator.pop(context, ),
        ),
        actions: <Widget>[TextButton(
          child: Text(
            '適用',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 17,
            ),
          ),
          onPressed: (){
            returnPgae(Events, title, content, selectedDays);
            Navigator.pop(context, Events);

          },
          
        )],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 15,
              child: Text("タイトル"),
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: TextFormField(
                onChanged: (value){
                  title = value;
                },
                decoration: const InputDecoration(
                  hintText: "title",
                )
              )
            ),
            SizedBox(
              width:350,
              height: 30,
              child: const Text("内容"),
            ),
            SizedBox(
              width: 350,
              height: 300,
              child: TextFormField(
                onChanged: (value) {
                  content = value;
                },
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      width: 0.5,
                    )
                  ),
                ),
              ),
            ),
          ],)
        ),
      ),
    );
  }
}