import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/screens/widgets/date_picker.dart';
import 'package:birth_daily/screens/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AddBirthday extends StatefulWidget {
  const AddBirthday({super.key});

  @override
  State<AddBirthday> createState() => _AddBirthdayState();
}

class _AddBirthdayState extends State<AddBirthday> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _date = TextEditingController();
  late Timestamp? birthdate;
  bool _isLovingOne = false;
  String imageURL = imageURLs[0];

  @override
  void dispose() {
    _name.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthdaysBloc, BirthdayState>(
      builder: (context, state) {
        if (state is BirthdayAdded) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(
                message: "Birthday Added",
                bkgColor: Colors.green,
                context: context);
          });
          _name.clear();
          _date.clear();
          imageURL = imageURLs[0];
        }

        if (state is BirthdayAddError) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(
                message: "Birthday not Added",
                bkgColor: Colors.red,
                context: context);
          });
        }
        if (state is BirthdayAvatarSelectedState) {
          imageURL = state.imageURL;
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Add birthday",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    children: [
                      Text(
                        "Select an Avatar",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        child: Image.asset(
                          imageURL,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<BirthdaysBloc>()
                                .add(BirthdayAvatarEditClickEvent());
                            context.push(
                              "/avatar-selector",
                              extra: 0,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.10,
                  ),
                  TextField(
                    controller: _name,
                    decoration: InputDecoration(
                        hintText: "Enter name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Icon(Icons.person_2_rounded)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _date,
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectDate =
                          await showBirthdatePicker(context: context);
                      if (selectDate != null) {
                        _date.text =
                            "${months[selectDate.month - 1]}/${selectDate.day}";
                        birthdate = Timestamp.fromDate(selectDate);
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Enter birth date",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Icon(Icons.calendar_today_rounded)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Make as loving one"),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isLovingOne = !_isLovingOne;
                            });
                          },
                          icon: Icon(
                            _isLovingOne
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: const Color(0xFFE85566),
                            size: 30,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.15,
                  ),
                  MaterialButton(
                    height: 50,
                    color: const Color(0xFFE85566),
                    onPressed: () {
                      context.read<BirthdaysBloc>().add(AddBirthdayEvent(
                          date: birthdate!,
                          name: _name.text,
                          imageURL: imageURL,
                          isLovingOne: _isLovingOne));
                    },
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Save",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
