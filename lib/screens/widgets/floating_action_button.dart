import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/blocs/internet_cubit/internet_cubit.dart';
import 'package:birth_daily/screens/widgets/snackbar_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget addBirthdayFloatingActionButton({required BuildContext context}) {
  return BlocBuilder<InternetCubit, InternetState>(
    builder: (context, state) {
      if (state is InternetStatus) {
        return FloatingActionButton.small(
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFF4849A0),
          onPressed: () {
            if (state.status == ConnectionStatus.connected) {
              context.read<BirthdaysBloc>().add(AddBirthdayClickEvent());
              context.push("/add-birthday");
            }
            if (state.status == ConnectionStatus.disconnected) {
              showConnectionErrorSnackBar(
                message: "You are offline. Cannot add birthdays",
                bkgColor: Colors.red,
                context: context,
                icon: Icons.wifi_off,
              );
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        );
      } else {
        return const SizedBox();
      }
    },
  );
}
