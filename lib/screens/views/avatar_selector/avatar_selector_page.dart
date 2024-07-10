import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarSelectorPage extends StatefulWidget {
  const AvatarSelectorPage({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  State<AvatarSelectorPage> createState() => _AvatarSelectorPageState();
}

class _AvatarSelectorPageState extends State<AvatarSelectorPage> {
  int selectedIndex = 0;
  @override
  void initState() {
    selectedIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select an Avatar",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: imageURLs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<BirthdaysBloc>().add(
                              BirthdayAvatarSelectedEvent(
                                  imageURL: imageURLs[index]));

                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: selectedIndex == index
                              ? const Color(0xFFE85566)
                              : Colors.white,
                          child: Stack(
                            children: [
                              Image.asset(
                                imageURLs[index],
                                fit: BoxFit.contain,
                                width: 150,
                                height: 140,
                              ),
                              selectedIndex == index
                                  ? const Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            // Container(
            //     alignment: Alignment(0, 0.95),
            //     child: Container(
            //       width: 300,
            //       height: 60,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         color: const Color(0xFFE85566),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: const Text(
            //         "Confirm",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(fontSize: 26),
            //       ),
            //     )),
          ]),
        ),
      ),
    );
  }
}
