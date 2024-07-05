import 'package:birth_daily/helpers/list_tile_colors.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:flutter/material.dart';

class BirthdayListTileHorizontal extends StatelessWidget {
  const BirthdayListTileHorizontal(
      {super.key, required this.index, required this.birthdayModel});
  final int index;
  final BirthdayModel birthdayModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: colors[index % colors.length],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            birthdayModel.imageURL,
            height: 70,
            width: 70,
          ),
          Text(
            birthdayModel.name[0].toUpperCase() +
                birthdayModel.name.substring(1),
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cake),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${months[birthdayModel.dateTime.toDate().month - 1]}/${birthdayModel.dateTime.toDate().day}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {},
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            color: const Color.fromARGB(255, 240, 113, 123),
            child: Text(
              "Send wishes",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
