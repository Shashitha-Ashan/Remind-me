import 'package:birth_daily/helpers/list_tile_colors.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

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
      child: Stack(
        children: [
          Column(
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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      color: const Color(0xFFF0717B),
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.cakeCandles,
                    color: Color(0xFFF0717B),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${months[birthdayModel.dateTime.toDate().month - 1]}/${birthdayModel.dateTime.toDate().day}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          color: const Color(0xFF000000),
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  context.push("/birthday-gift");
                },
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color(0xFFF0717B),
                child: Text(
                  "Send wishes",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          ),
          Positioned(
            top: 1,
            right: 1,
            child: birthdayModel.isLovingOne
                ? const Icon(
                    FontAwesomeIcons.solidHeart,
                    color: Color(0xFFE85566),
                    size: 25,
                    shadows: [
                      Shadow(blurRadius: 1, offset: Offset(1, 0)),
                    ],
                  )
                : const Icon(null),
          )
        ],
      ),
    );
  }
}
