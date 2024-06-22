import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Home"),
              background: Image.asset(
                "assets/backgrounds/back.png",
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.push("/settings");
                },
                icon: const Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  context.push("/search");
                },
                icon: const Icon(Icons.output),
              ),
            ],
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     childCount: 20,
          //     (context, index) {
          //       return ListTile(
          //         title: Text("$index ashan"),
          //       );
          //     },
          //   ),
          // ),
          SliverToBoxAdapter(
            child: BlocBuilder<BirthdaysBloc, BirthdaysState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is SuccessLoadState) {
                  return Text(
                      "Name - ${state.birthdayModel.name}Date - ${state.birthdayModel.dateTime}");
                }
                return const Text("error occured");
              },
            ),
          )
        ],
      ),
    );
  }
}
