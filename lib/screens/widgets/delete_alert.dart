import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> deleteBirthdayAlert(
    {required BuildContext context, required String docId}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: const Text(
          "Are you sure you want to delete this birthday?",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<BirthdaysBloc>().add(DeleteBirthdayEvent(id: docId));
              context.go("/main");
            },
            child: const Text("Ok"),
          ),
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}
