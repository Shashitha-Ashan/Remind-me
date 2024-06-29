import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BirthdayCalendar extends StatefulWidget {
  const BirthdayCalendar({super.key, required this.focusedDay});

  final DateTime focusedDay;
  @override
  State<BirthdayCalendar> createState() => _BirthdayCalendarState();
}

class _BirthdayCalendarState extends State<BirthdayCalendar> {
  late DateTime focusedDay;
  @override
  void initState() {
    focusedDay = widget.focusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Birthday calendar"),
      ),
      body: Column(
        children: [
          TableCalendar(
              focusedDay: focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.now())
        ],
      ),
    );
  }
}
