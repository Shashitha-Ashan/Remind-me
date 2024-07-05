import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BirthdayUserProfile extends StatelessWidget {
  BirthdayUserProfile({super.key, required this.birthdayModel});

  final BirthdayModel birthdayModel;
  final TextEditingController _date = TextEditingController();
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String birthdate =
        "${months[birthdayModel.dateTime.toDate().month - 1]}/${birthdayModel.dateTime.toDate().day}";
    _date.text = birthdate;
    _name.text =
        birthdayModel.name[0].toUpperCase() + birthdayModel.name.substring(1);
    return BlocBuilder<BirthdaysBloc, BirthdayState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              birthdayModel.name[0].toUpperCase() +
                  birthdayModel.name.substring(1),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<BirthdaysBloc>().add(
                        UpdateBirthdayClickEvent(docId: birthdayModel.id!));
                    context.push("/add-birthday");
                  },
                  icon: const Icon(Icons.edit))
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
                          birthdayModel.imageURL,
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                        ),
                        birthdayModel.isLovingOne
                            ? const Positioned(
                                top: 10,
                                right: 20,
                                child: Icon(
                                  Icons.favorite,
                                  size: 35,
                                  color: Color(0xFFE85566),
                                ))
                            : const SizedBox()
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
                        readOnly: true,
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _date,
                        style: Theme.of(context).textTheme.titleLarge,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Birthdate",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        height: 50,
                        color: const Color(0xFFE85566),
                        onPressed: () {
                          // context.go("");
                        },
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Send a Wish",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                      )
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
