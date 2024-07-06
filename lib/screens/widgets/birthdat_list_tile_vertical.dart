import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/list_tile_colors.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:birth_daily/screens/views/birthday_user_profile/birthday_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdatListTileVertical extends StatelessWidget {
  BirthdatListTileVertical(
      {super.key, required this.index, required this.birthdayModel});

  final int index;
  final BirthdayModel birthdayModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BirthdayUserProfile(
                birthdayModel: birthdayModel,
              ),
            ));
        context
            .read<BirthdaysBloc>()
            .add(BirthdayProfileEvent(docId: birthdayModel.id!));
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
              birthdayModel.imageURL,
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
                  birthdayModel.name[0].toUpperCase() +
                      birthdayModel.name.substring(1),
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
                      "${months[birthdayModel.dateTime.toDate().month - 1]}/${birthdayModel.dateTime.toDate().day}",
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
