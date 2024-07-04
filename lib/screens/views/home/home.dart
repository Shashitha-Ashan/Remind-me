import 'package:birth_daily/helpers/date_time_helper.dart';
import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/screens/widgets/birthdat_list_tile_vertical.dart';
import 'package:birth_daily/screens/widgets/birthday_list_tile_horizontal.dart';
import 'package:birth_daily/screens/widgets/floating_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: const Center(
          child: Text("User not logged in"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
              onPressed: () {
                context.push("/search");
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: addBirthdayFloatingActionButton(context: context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("birthdays")
            .where('uid', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<dynamic> todayList =
                DateTimeHelper.getTodayBirthdays(list: snapshot.data!.docs);
            List<dynamic> upcomingList =
                DateTimeHelper.getUpcomingBirthdays(list: snapshot.data!.docs);
            List<dynamic> pastList =
                DateTimeHelper.getPastBirthdays(list: snapshot.data!.docs);

            return SingleChildScrollView(
              child: Column(
                children: [
                  if (todayList.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            "Today's Birthdays",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        listBuilder(list: todayList, isHorizontal: true),
                      ],
                    ),
                  ],
                  if (upcomingList.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            "Upcoming Birthdays",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    listBuilder(list: upcomingList, isHorizontal: false),
                  ],
                  if (pastList.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            "Past Birthdays",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    listBuilder(list: pastList, isHorizontal: false),
                  ],
                  if (todayList.isEmpty &&
                      upcomingList.isEmpty &&
                      pastList.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No birthdays found",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 16, color: Colors.black),
                      ),
                    ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "No birthdays found",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16, color: Colors.black),
              ),
            );
          }
        },
      ),
    );
  }

  Widget listBuilder(
      {required List<dynamic> list, required bool isHorizontal}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: isHorizontal ? MediaQuery.of(context).size.height * 0.3 : null,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
              height: 10,
            );
          },
          itemCount: list.length,
          scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
          itemBuilder: (context, index) {
            final todayName = list[index]["name"];
            final Timestamp todayTimestamp = list[index]['date'];
            return isHorizontal
                ? BirthdayListTileHorizontal(
                    index: index,
                    name: todayName,
                    imageURL: imageURLs[0],
                    date: todayTimestamp.toDate())
                : BirthdatListTileVertical(
                    index: index,
                    name: todayName,
                    imageURL: imageURLs[1],
                    date: todayTimestamp.toDate());
          },
        ),
      ),
    );
  }
}
