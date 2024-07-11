import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/blocs/internet_cubit/internet_cubit.dart';
import 'package:birth_daily/helpers/list_tile_colors.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:birth_daily/screens/views/birthday_user_profile/birthday_user_profile.dart';
import 'package:birth_daily/screens/widgets/snackbar_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BirthdatListTileVertical extends StatelessWidget {
  BirthdatListTileVertical(
      {super.key, required this.index, required this.birthdayModel});

  final int index;
  final BirthdayModel birthdayModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetStatus) {
          return GestureDetector(
            onTap: () {
              if (state.status == ConnectionStatus.connected) {
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
              }
              if (state.status == ConnectionStatus.disconnected) {
                showConnectionErrorSnackBar(
                  message: "You are offline. Cannot edit birthday",
                  bkgColor: Colors.red,
                  context: context,
                  icon: Icons.wifi_off,
                );
              }
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    birthdayModel.imageURL,
                    height: 100,
                    width: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        birthdayModel.name[0].toUpperCase() +
                            birthdayModel.name.substring(1),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 26, color: const Color(0xFFE85566)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(FontAwesomeIcons.cakeCandles,
                              color: Color(0xFFE85566)),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: birthdayModel.isLovingOne
                        ? const Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Color(0xFFE85566),
                            size: 40,
                            shadows: [
                              Shadow(blurRadius: 1, offset: Offset(1, 1)),
                            ],
                          )
                        : const Icon(null),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
