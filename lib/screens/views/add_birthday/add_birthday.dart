import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AddBirthday extends StatefulWidget {
  const AddBirthday({super.key});

  @override
  State<AddBirthday> createState() => _AddBirthdayState();
}

class _AddBirthdayState extends State<AddBirthday> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _date = TextEditingController();

  bool _isFav = false;

  final dropDownItems = [
    DropdownMenuEntry(
      label: "male",
      value: "male",
    ),
    DropdownMenuEntry(
      label: "female",
      value: "male",
    ),
    DropdownMenuEntry(
      label: "transgender",
      value: "male",
    ),
  ];
  @override
  void dispose() {
    _name.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add birthday",
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              UserAvatar(
                size: 120,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.10,
              ),
              Column(
                children: [
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
                  DropdownMenu(
                    dropdownMenuEntries: dropDownItems,
                    hintText: "Gender",
                    width: MediaQuery.of(context).size.width * 0.95,
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Make as loving one"),
                      // Switch(
                      //   activeTrackColor: const Color(0xFFE85566),
                      //   value: true,
                      //   onChanged: (value) {},
                      // )
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isFav = !_isFav;
                            });
                          },
                          icon: Icon(
                            _isFav ? Icons.favorite : Icons.favorite_outline,
                            color: const Color(0xFFE85566),
                            size: 30,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.75,
                height: 50,
                color: const Color(0xFFE85566),
                onPressed: () {},
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  "Save",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
