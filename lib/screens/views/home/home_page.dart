import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<BirthdaysBloc>().add(LoadBirthdaysEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("RemindMe"),
          actions: [
            IconButton(
              onPressed: () {
                context.push("/settings");
              },
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {
                context.push("/profile");
              },
              icon: const Icon(Icons.person_2_sharp),
            ),
            IconButton(
              onPressed: () {
                context.push("/search");
              },
              icon: const Icon(Icons.output),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              text: "Today",
            ),
            Tab(
              text: "Upcoming",
            ),
          ]),
          flexibleSpace: Image.asset(
            "assets/backgrounds/back.png",
            fit: BoxFit.fill,
          ),
          toolbarHeight: 70,
        ),
        body: TabBarView(
          children: [
            FirestoreListView(
              query: FirebaseFirestore.instance.collection('birthdays'),
              itemBuilder: (context, doc) {
                final birthday = doc.data();
                final date = birthday['date'].toDate();
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Material(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.amber,
                    child: GridTile(
                      child: Icon(Icons.person),
                    ),
                  ),
                );
              },
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Icon(Icons.person),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
