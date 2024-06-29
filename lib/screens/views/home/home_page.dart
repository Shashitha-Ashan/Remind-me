import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/screens/widgets/add_birthday.dart';
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
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  @override
  void initState() {
    context.read<BirthdaysBloc>().add(LoadBirthdaysEvent());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(
      () {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          setState(() {
            isVisible = false;
          });
        }
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          setState(() {
            isVisible = true;
          });
        }
      },
    );
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(microseconds: 200),
        child: BottomAppBar(
          height: isVisible ? 70 : 0,
          elevation: 5,
          color: const Color(0xFFE85566),
          shape: const CircularNotchedRectangle(),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.push("/home");
                },
                icon: const Icon(Icons.home_filled),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  context.push("/profile");
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.push("/search");
                },
                icon: const Icon(Icons.card_giftcard_rounded),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  context.push("/settings");
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        shape: const CircleBorder(),
        backgroundColor: Color(0xFF4849A0),
        onPressed: () {},
        child: IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showBottomsheet(context);
          },
        ),
      ),
      floatingActionButtonLocation: isVisible
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.miniEndFloat,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("birthdays")
            .where('uid', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final name = snapshot.data?.docs[index]['name'];
                  final Timestamp timestamp =
                      snapshot.data?.docs[index]['date'];

                  final date = timestamp.toDate().day;
                  final month = timestamp.toDate().month;

                  return Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9CBCF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 26),
                        ),
                        Text(
                          "${months[month - 1]}/$date",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            } else {
              return const Center(
                child: Text("No data to display"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
