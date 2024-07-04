import 'package:birth_daily/helpers/list_tile_colors.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/screens/views/birthday_user_profile/birthday_user_profile.dart';
import 'package:flutter/material.dart';

class BirthdatListTileVertical extends StatelessWidget {
  BirthdatListTileVertical(
      {super.key,
      required this.date,
      required this.name,
      required this.imageURL,
      required this.index});

  final String name;
  final String imageURL;
  final DateTime date;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BirthdayUserProfile(
                name: name,
                date: date,
              ),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: colors[index % colors.length],
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            Image.asset(
              imageURL,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name[0].toUpperCase() + name.substring(1),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 26, color: const Color(0xFFE85566)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cake, color: Color(0xFFE85566)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${months[date.month - 1]}/${date.day}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
