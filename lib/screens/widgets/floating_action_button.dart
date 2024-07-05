import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget addBirthdayFloatingActionButton({required BuildContext context}) {
  return FloatingActionButton.small(
    shape: const CircleBorder(),
    backgroundColor: const Color(0xFF4849A0),
    onPressed: () {},
    child: IconButton(
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        context.read<BirthdaysBloc>().add(AddBirthdayClickEvent());
        context.push("/add-birthday");
      },
    ),
  );
}
