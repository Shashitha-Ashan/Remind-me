import 'package:birth_daily/helpers/date_time_helper.dart';
import 'package:birth_daily/screens/widgets/birthdat_list_tile_vertical.dart';
import 'package:birth_daily/screens/widgets/floating_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

class BirthdayCalendar extends StatefulWidget {
  const BirthdayCalendar({super.key});
  @override
  State<BirthdayCalendar> createState() => _BirthdayCalendarState();
}

class _BirthdayCalendarState extends State<BirthdayCalendar> {
  late DateTime _focusedDay;
  DateTime _selectedDay = DateTime.now();
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _focusedDay = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> _list = [];
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("birthdays")
            .where('uid', isEqualTo: _user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _list = DateTimeHelper.getSelectedDateBirthdays(
                list: snapshot.data!.docs, selectedDate: _selectedDay);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Birthday calendar",
              ),
            ),
            floatingActionButton:
                addBirthdayFloatingActionButton(context: context),
            body: Column(
              children: [
                TableCalendar(
                  calendarStyle: CalendarStyle(
                    cellMargin: EdgeInsets.all(5),
                  ),
                  rowHeight: 40,
                  daysOfWeekHeight: 25,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Birthday List",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 2,
                  child: _list.isNotEmpty
                      ? ListView.separated(
                          itemCount: _list.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (context, index) {
                            if (_list.isNotEmpty) {
                              final DateTime date =
                                  _list[index]['date'].toDate();
                              final name = _list[index]['name'];
                              return BirthdatListTileVertical(
                                index: index,
                                name: name,
                                date: date,
                                imageURL: "assets/avatars/2.png",
                              );
                            }
                          },
                        )
                      : Center(
                          child: SvgPicture.asset(
                            'assets/svg/no_data.svg',
                            width: 120,
                            height: 120,
                          ),
                        ),
                )
              ],
            ),
          );
        });
  }
}
