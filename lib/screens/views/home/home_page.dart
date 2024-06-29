import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/screens/widgets/add_birthday.dart';
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
  bool isVisible = true;
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
          color: Colors.blue,
          shape: const CircularNotchedRectangle(),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.push("/home");
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  context.push("/profile");
                },
                icon: Icon(
                  Icons.person_2_sharp,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  context.push("/search");
                },
                icon: const Icon(Icons.output),
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
        onPressed: () {},
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showBottomsheet(context);
          },
        ),
      ),
      floatingActionButtonLocation: isVisible
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.miniEndFloat,
      body: BlocBuilder<BirthdaysBloc, BirthdayState>(
        builder: (context, state) {
          if (state is BirthdaysLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BirthdaysSuccessLoadState) {
            if (state.birthdays.isEmpty) {
              return const Center(
                child: Text("No birthdays to display"),
              );
            } else {
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final name = state.birthdays[index].name;
                  final month =
                      state.birthdays[index].dateTime.toDate().month + 1;
                  final date = state.birthdays[index].dateTime.toDate().day;
                  return Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                      color: Colors.red,
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
                          "${month}/${date}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.birthdays.length,
              );
            }
          } else {
            return const Center(
              child: Text("Somethig went wrong"),
            );
          }
        },
      ),
    );
  }
}
