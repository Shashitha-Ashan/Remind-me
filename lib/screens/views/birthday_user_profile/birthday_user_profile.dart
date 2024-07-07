import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:birth_daily/screens/widgets/date_picker.dart';
import 'package:birth_daily/screens/widgets/delete_alert.dart';
import 'package:birth_daily/screens/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BirthdayUserProfile extends StatefulWidget {
  const BirthdayUserProfile({super.key, required this.birthdayModel});

  final BirthdayModel birthdayModel;

  @override
  State<BirthdayUserProfile> createState() => _BirthdayUserProfileState();
}

class _BirthdayUserProfileState extends State<BirthdayUserProfile> {
  bool editAccess = false;

  final TextEditingController _date = TextEditingController();

  final TextEditingController _name = TextEditingController();
  String birthdate = "";

  bool isLovingOne = false;

  String imageURL = imageURLs[0];

  late Timestamp date;
  late String docId;
  @override
  void initState() {
    birthdate =
        "${months[widget.birthdayModel.dateTime.toDate().month - 1]}/${widget.birthdayModel.dateTime.toDate().day}";
    _date.text = birthdate;
    _name.text = widget.birthdayModel.name;
    isLovingOne = widget.birthdayModel.isLovingOne;
    imageURL = widget.birthdayModel.imageURL;
    date = widget.birthdayModel.dateTime;
    docId = widget.birthdayModel.id!;
    super.initState();
  }

  @override
  void dispose() {
    _date.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthdaysBloc, BirthdayState>(
      builder: (context, state) {
        if (state is BirthdayDateUpdatedState) {
          _date.text =
              "${months[state.date.toDate().month - 1]}/${state.date.toDate().day}";
          date = state.date;
        }
        if (state is BirthdayEditAccessState) {
          editAccess = state.editAccess;
        }
        if (state is BirthdayNameUpdatedState) {
          _name.text = state.name;
        }
        if (state is BirthdayDateUpdatedState) {
          date = state.date;
        }
        if (state is BirthdayLovingOneUpdatedState) {
          editAccess = true;
          isLovingOne = state.isLovingOne;
        }
        if (state is BirthdayImageUpdatedState) {
          imageURL = state.imageURL;
        }
        if (state is BirthdayLovingOneUpdatedState) {
          isLovingOne = state.isLovingOne;
        }
        if (state is BirthdayUpdated) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(
                message: "Birthday Updated",
                bkgColor: Colors.green,
                context: context);
          });
          context
              .read<BirthdaysBloc>()
              .add(BirthdayEditAccessEvent(editAccess: false));
        }
        if (state is BirthdayUpdateError) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(
                message: "Birthday not Updated",
                bkgColor: Colors.red,
                context: context);
          });
        }
        if (state is BirthdayDeleted) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(
                message: "Birthday Deleted",
                bkgColor: Colors.green,
                context: context);
          });
        }
        if (state is BirthdayDeleteError) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(
                message: "Birthday not Deleted",
                bkgColor: Colors.red,
                context: context);
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _name.text[0].toUpperCase() + _name.text.substring(1),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await deleteBirthdayAlert(context: context, docId: docId);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          imageURL,
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                            top: 10,
                            right: 20,
                            child: IconButton(
                              onPressed: () {
                                // isLoving update method

                                context.read<BirthdaysBloc>().add(
                                    BirthdayLovingOneUpdatedEvent(
                                        isLovingOne: !isLovingOne));
                              },
                              icon: isLovingOne
                                  ? const Icon(
                                      shadows: [
                                        Shadow(
                                            blurRadius: 50,
                                            color: Colors.black54,
                                            offset: Offset(1, 1))
                                      ],
                                      Icons.favorite,
                                      size: 35,
                                      color: Color(0xFFE85566),
                                    )
                                  : const Icon(
                                      shadows: [
                                        Shadow(
                                            blurRadius: 50,
                                            color: Colors.black54,
                                            offset: Offset(1, 1))
                                      ],
                                      Icons.favorite_outline,
                                      size: 35,
                                      color: Color(0xFFE85566),
                                    ),
                            ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Details",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _name,
                        readOnly: !editAccess,
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: () {
                                // name update method
                                context.read<BirthdaysBloc>().add(
                                    BirthdayEditAccessEvent(editAccess: true));
                              },
                              icon: const Icon(Icons.edit)),
                          label: const Icon(FontAwesomeIcons.solidUser),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          context
                              .read<BirthdaysBloc>()
                              .add(BirthdayNameUpdatedEvent(name: value));
                        },
                        controller: _date,
                        style: Theme.of(context).textTheme.titleLarge,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: () async {
                                // date update method
                                context.read<BirthdaysBloc>().add(
                                    BirthdayEditAccessEvent(editAccess: true));
                                DateTime? selectDate =
                                    await showBirthdatePicker(context: context);
                                if (selectDate != null) {
                                  context.read<BirthdaysBloc>().add(
                                        BirthdayDateUpdatedEvent(
                                          date: Timestamp.fromDate(selectDate),
                                        ),
                                      );
                                }
                              },
                              icon: const Icon(Icons.edit)),
                          label: const Icon(FontAwesomeIcons.cakeCandles),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      editAccess
                          ? MaterialButton(
                              height: 50,
                              color: const Color(0xFFE85566),
                              onPressed: () {
                                if (_name.text != "" && date != null) {
                                  context.read<BirthdaysBloc>().add(
                                        UpdateBirthdayEvent(
                                            date: date,
                                            id: docId,
                                            imageURL: imageURL,
                                            isLovingOne: isLovingOne,
                                            name: _name.text),
                                      );
                                }
                              },
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                "Update",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(fontSize: 20),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
