import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:birth_daily/repositories/birthday_list/birthday_list.dart';
import 'package:birth_daily/screens/widgets/birthdat_list_tile_vertical.dart';
import 'package:birth_daily/screens/widgets/floating_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  late ScrollController _scrollController;
  bool isDowning = false;
  bool isUpping = false;
  bool isScrolling = false;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListner);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListner() {
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        isDowning == false) {
      isDowning = true;
      isUpping = false;
      setState(() {
        isScrolling = true;
      });
    }
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        isUpping == false) {
      isUpping = true;
      isDowning = false;
      setState(() {
        isScrolling = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BirthdayModel> list = [];
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("birthdays")
            .where('uid', isEqualTo: _user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            list = context.read<BirthdayListRepo>().getSelectedDateBirthdayList(
                list: snapshot.data!.docs, selectedDate: _selectedDay);
          }
          return SafeArea(
            child: Scaffold(
              floatingActionButton:
                  addBirthdayFloatingActionButton(context: context),
              body: Column(
                children: [
                  TableCalendar(
                    calendarFormat: isScrolling
                        ? CalendarFormat.week
                        : CalendarFormat.month,
                    calendarStyle: const CalendarStyle(
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
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: list.isNotEmpty
                        ? ListView.separated(
                            controller: _scrollController,
                            itemCount: list.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (context, index) {
                              if (list.isNotEmpty) {
                                return BirthdatListTileVertical(
                                  index: index,
                                  birthdayModel: list[index],
                                );
                              }
                              return null;
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
            ),
          );
        });
  }
}
