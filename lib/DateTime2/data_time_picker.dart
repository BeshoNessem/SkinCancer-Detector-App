import 'package:flutter/material.dart';
import 'package:flutter_app/DateTime2/notification_dialog_2.dart';
import 'package:intl/intl.dart';
class DateTime2 extends StatefulWidget {
  const DateTime2({Key? key}) : super(key: key);

  @override
  _DateTime2State createState() => _DateTime2State();
}

class _DateTime2State extends State<DateTime2> {
  DateTime selectedDate = DateTime.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(dateFormat.format(selectedDate)),
        RaisedButton(
          child: Text('Choose new date time'),
          onPressed: () async {
            final selectedDate = await _selectDateTime(context);
            if (selectedDate == null) return;

            print(selectedDate);

            final selectedTime = await _selectTime(context);
            if (selectedTime == null) return;
            print(selectedTime);

            setState(() {
              this.selectedDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );
            });
          },
        ),
      ],
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(seconds: 1)),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );
  }
