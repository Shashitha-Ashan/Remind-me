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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                context.push("/settings");
              },
              icon: const Icon(Icons.settings),
            ),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                context.push("/profile");
              },
              icon: const Icon(Icons.person_2_sharp),
            ),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                context.push("/search");
              },
              icon: const Icon(Icons.output),
            ),
          ),
        ],
      ),
      body: GridView.builder(
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
      ),
    );
  }
}
