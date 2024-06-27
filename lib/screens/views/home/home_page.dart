import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
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
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: isVisible
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.miniEndFloat,
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: const Icon(Icons.person),
          );
        },
        itemCount: 15,
      ),
    );
  }
}
