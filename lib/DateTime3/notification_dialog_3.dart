import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Doctor2/home_page.dart';
import 'package:intl/intl.dart';

Future<TimeOfDay?> _selectTime(BuildContext context, {required DateTime initialDate}) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: initialDate.hour, minute: initialDate.minute),
  );
}

Future<DateTime?> _selectDateTime(BuildContext context, {required DateTime initialDate}) {
  final now = DateTime.now();
  final newestDate = initialDate.isAfter(now) ? initialDate : now;

  return showDatePicker(
    context: context,
    initialDate: newestDate.add(Duration(seconds: 1)),
    firstDate: now,
    lastDate: DateTime(2100),
  );
}

Dialog? showDateTimeDialog(
    BuildContext context, {
      required ValueChanged<DateTime> onSelectedDate,
      required DateTime initialDate,
    }) {
  final dialog = Dialog(
    child: DateTimeDialog(onSelectedDate: onSelectedDate, initialDate: initialDate),
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
}

class DateTimeDialog extends StatefulWidget {
  final ValueChanged<DateTime> onSelectedDate;
  final DateTime initialDate;

  const DateTimeDialog({
    required this.onSelectedDate,
    required this.initialDate,
    Key? key,
  }) : super(key: key);
  @override
  _DateTimeDialogState createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  late DateTime selectedDate;
  String name3 = "Name loading ....";
  String phone3 = "phone loading ....";
  String email3='email loading ...';
  String url3='Image loading ...';
  String name = "Name loading ....";
  String phone = "phone loading ....";
  String email='email loading ...';
  String url='Image loading ...';
  Future<void> getDataPatient() async {
    var vari = await FirebaseFirestore.instance
        .collection('users').doc(user.uid).get();
    setState(() {
      name = vari.data()!['name'];
      phone=vari.data()!['phone'];
      email=vari.data()!['email'];
      url=vari.data()!['profileImage'];
    });
  }
  void getData() async {
    var vari = await FirebaseFirestore.instance
        .collection('Doctor').doc("RMUvSVFMUgg7MN8rcCQ11i8JJcA2").get();
    setState(() {
      name3 = vari.data()!['name'];
      phone3=vari.data()!['phone'];
      email3=vari.data()!['email'];
      url3=vari.data()!['photoURL'];
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
    getDataPatient();
    selectedDate = widget.initialDate;
  }
  final user =FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Select time',
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
              onPressed: () async {
                final date = await _selectDateTime(context, initialDate: selectedDate);
                if (date == null) return;

                setState(() {
                  selectedDate = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    selectedDate.hour,
                    selectedDate.minute,
                  );
                });

                widget.onSelectedDate(selectedDate);
              },
            ),
            const SizedBox(width: 8),
            RaisedButton(
              child: Text(DateFormat('HH:mm').format(selectedDate)),
              onPressed: () async {
                final time = await _selectTime(context, initialDate: selectedDate);
                if (time == null) return;

                setState(() {
                  selectedDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    time.hour,
                    time.minute,
                  );
                });

                widget.onSelectedDate(selectedDate);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        OutlineButton(
          child: Text('Schedule!'),
          onPressed: () {
            uploadDate();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
          highlightColor: Colors.orange,
        ),
      ],
    ),
  );
  Future uploadDate() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("Appointmnet")
        .add({'Appointment':selectedDate.toString(),'name':name3,'phone':phone3,'email':email3,'photoURL':url3});
    await firebaseFirestore
        .collection("Doctor")
        .doc("RMUvSVFMUgg7MN8rcCQ11i8JJcA2")
        .collection("Appointment")
        .add({'Date':selectedDate.toString(),'name':name,'phone':phone,'photoURL':url});
  }
}
