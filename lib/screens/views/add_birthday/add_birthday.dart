import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/helpers/months_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool isEditMode = false;
  int _selectedImageIndex = 0;
  String? _docId;

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
        if (state is BirthdayUpdateState) {
          print("awaaa");
          _selectedImageIndex = imageURLs.indexWhere(
            (element) => element == state.imageURL,
          );
          isEditMode = true;
          _name.text = state.name;
          _date.text =
              "${months[state.date.toDate().month - 1]}/${state.date.toDate().day}";
          _isLovingOne = state.isLovingOne;
          _docId = state.docId;
        }
        if (state is BirthdayAdd) {
          isEditMode = false;
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              isEditMode ? "Edit birthday" : "Add birthday",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                    itemCount: imageURLs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3C3C9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  imageURLs[index],
                                  height: 120,
                                  width: 80,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              _selectedImageIndex == index
                                  ? const Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ))
                                  : const Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.white,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListView(
                    children: [
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
                          DateTime? selectDate = await showDatePicker(
                            keyboardType: TextInputType.datetime,
                            initialDatePickerMode: DatePickerMode.day,
                            initialEntryMode: DatePickerEntryMode.input,
                            context: context,
                            firstDate: DateTime(
                              1900,
                              DateTime.january,
                            ),
                            lastDate: DateTime(
                              DateTime.now().year,
                              DateTime.december,
                            ),
                          );
                          if (selectDate != null) {
                            birthdate = Timestamp.fromDate(selectDate);
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter birth date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon:
                                const Icon(Icons.calendar_today_rounded)),
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
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
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
                          if (state is BirthdayAdd) {
                            context.read<BirthdaysBloc>().add(AddBirthdayEvent(
                                date: birthdate!,
                                name: _name.text,
                                imageURL: imageURLs[_selectedImageIndex],
                                isLovingOne: _isLovingOne));
                          }
                          if (state is BirthdayUpdateState) {
                            print("update state");
                            context.read<BirthdaysBloc>().add(
                                UpdateBirthdayEvent(
                                    date: birthdate!,
                                    id: _docId!,
                                    name: _name.text,
                                    imageURL: imageURLs[_selectedImageIndex],
                                    isLovingOne: _isLovingOne));
                          }
                        },
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          isEditMode ? "Update" : "Save",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
