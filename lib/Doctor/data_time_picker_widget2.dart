import 'package:flutter/material.dart';
import 'package:flutter_app/Doctor2/home_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/Doctor/notification_dialog.dart';

class DateTimePickerWidget2 extends StatefulWidget {
  @override
  _DateTimePickerWidget2State createState() => _DateTimePickerWidget2State();
}

class _DateTimePickerWidget2State extends State<DateTimePickerWidget2> {
  DateTime selectedDate = DateTime.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));
            },
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
               Column(children: [
                Image.asset("assets/images/icons8-pay-date-100.png")
              ],),

                Text(dateFormat.format(selectedDate)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 300,top: 120),
                  child: Container(
                    child: RaisedButton(
                        child: Text('Choose new date time',style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed: () async {
                          showDateTimeDialog(context, initialDate: selectedDate,
                              onSelectedDate: (selectedDate) {
                                setState(() {
                                  this.selectedDate = selectedDate;
                                });
                              });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ),
            ],
          ),
        )
    );
  }
}
