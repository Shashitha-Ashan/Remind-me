import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/screens/widgets/date_picker.dart';
import 'package:birth_daily/screens/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();

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

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, perform the save action
      context.read<BirthdaysBloc>().add(AddBirthdayEvent(
          date: birthdate!,
          name: _name.text,
          imageURL: imageURL,
          isLovingOne: _isLovingOne));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BirthdaysBloc, BirthdayState>(
      listener: (context, state) {
        if (state is BirthdayAdded) {
          showSnackBar(
              message: "Birthday Added",
              bkgColor: Colors.green,
              context: context);
          _name.clear();
          _date.clear();
          imageURL = imageURLs[0];
        }

        if (state is BirthdayAddError) {
          showSnackBar(
              message: "Birthday not Added",
              bkgColor: Colors.red,
              context: context);
        }
      },
      builder: (context, state) {
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
              child: Form(
                key: _formKey,
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
                          radius: 50,
                          child: Image.asset(
                            imageURL,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
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
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.10,
                    ),
                    TextFormField(
                      controller: _name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a birth date';
                        }
                        return null;
                      },
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
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: MaterialButton(
                        color: const Color(0xFFE85566),
                        onPressed: () {
                          _saveForm();
                        },
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Save",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
