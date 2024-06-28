import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBottomsheet(BuildContext context) {
  final TextEditingController textEditingController = TextEditingController();
  showModalBottomSheet(
    showDragHandle: true,
    sheetAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 300),
    ),
    context: context,
    builder: (context) {
      return BlocBuilder<BirthdaysBloc, BirthdayState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Add Birthday",
                  style: TextStyle(fontSize: 28),
                ),
                TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: "Friend name",
                    label: Text("Friend name"),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<BirthdaysBloc>().add(AddBirthdayEvent(
                          name: "saman", date: DateTime.now()));
                    },
                    child: Text("Add"))
              ],
            ),
          );
        },
      );
    },
  );
}
