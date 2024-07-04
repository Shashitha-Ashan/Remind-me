import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/date_time_helper.dart';
import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/screens/widgets/add_birthday.dart';
import 'package:birth_daily/screens/widgets/birthdat_list_tile_vertical.dart';
import 'package:birth_daily/screens/widgets/birthday_list_tile_horizontal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final User? user = FirebaseAuth.instance.currentUser;

  bool isVisible = true;

  @override
  void initState() {
    context.read<BirthdaysBloc>().add(LoadBirthdaysEvent());
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisible) {
        setState(() {
          isVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isVisible) {
        setState(() {
          isVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("birthdays")
              .where('uid', isEqualTo: user?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            late List<dynamic> todayList;
            late List<dynamic> upcomingList;
            if (snapshot.hasData) {
              todayList =
                  DateTimeHelper.getTodayBirthdays(list: snapshot.data!.docs);
              upcomingList = DateTimeHelper.getUpcomingBirthdays(
                  list: snapshot.data!.docs);
              return SafeArea(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Today's",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: todayList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final todayName = todayList[index]["name"];
                            final Timestamp todayTimestamp =
                                todayList[index]['date'];
                            return BirthdayListTileHorizontal(
                                index: index,
                                name: todayName,
                                imageURL: imageURLs[0],
                                date: todayTimestamp.toDate());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Upcoming",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: upcomingList.length,
                          itemBuilder: (context, index) {
                            final upcomingName = upcomingList[index]["name"];
                            final Timestamp upcomingTimestamp =
                                upcomingList[index]['date'];
                            return BirthdatListTileVertical(
                                index: index,
                                name: upcomingName,
                                imageURL: "assets/avatars/2.png",
                                date: upcomingTimestamp.toDate());
                          },
                        )),
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SafeArea(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }
            return const SafeArea(
                child: Center(
              child: Text("something went wrong"),
            ));
          }),
    );
  }
}
