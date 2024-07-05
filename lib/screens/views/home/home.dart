import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:birth_daily/repositories/birthday_list/birthday_list.dart';
import 'package:birth_daily/screens/widgets/birthdat_list_tile_vertical.dart';
import 'package:birth_daily/screens/widgets/birthday_list_tile_horizontal.dart';
import 'package:birth_daily/screens/widgets/floating_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: const Text(
          "Home",
        ),
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
            List<BirthdayModel> todayList = context
                .read<BirthdayListRepo>()
                .getTodayBirthdayList(list: snapshot.data!.docs);
            List<BirthdayModel> upcomingList = context
                .read<BirthdayListRepo>()
                .getUpcomingBirthdayList(list: snapshot.data!.docs);
            List<BirthdayModel> pastList = context
                .read<BirthdayListRepo>()
                .getPastBirthdayList(list: snapshot.data!.docs);

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
                                .copyWith(
                                    fontSize: 16,
                                    color: const Color(0xFFE85566)),
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
                                .copyWith(
                                    fontSize: 16,
                                    color: const Color(0xFFE85566)),
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 16, color: const Color(0xFFE85566)),
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
                    .copyWith(fontSize: 16, color: const Color(0xFFE85566)),
              ),
            );
          }
        },
      ),
    );
  }

  Widget listBuilder(
      {required List<BirthdayModel> list, required bool isHorizontal}) {
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
            return isHorizontal
                ? BirthdayListTileHorizontal(
                    index: index,
                    birthdayModel: list[index],
                  )
                : BirthdatListTileVertical(
                    index: index,
                    birthdayModel: list[index],
                  );
          },
        ),
      ),
    );
  }
}
