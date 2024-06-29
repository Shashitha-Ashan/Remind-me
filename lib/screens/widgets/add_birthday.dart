import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBottomsheet(BuildContext context) {
  final TextEditingController textEditingController = TextEditingController();
  late DateTime? dateTime;

  showModalBottomSheet(
    isScrollControlled: true,
    elevation: 50,
    useSafeArea: true,
    showDragHandle: true,
    sheetAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 300),
    ),
    context: context,
    builder: (context) {
      return BlocBuilder<BirthdaysBloc, BirthdayState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Add Birthday",
                    style: TextStyle(fontSize: 28),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                        hintText: "Friend name",
                        label: Text("Friend name"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onTap: () async {
                      dateTime = await showDatePicker(
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
                    },
                    decoration: const InputDecoration(
                        hintText: "mm/dd/yyyy",
                        label: Text("mm/dd/yyyy"),
                        prefixIcon: Icon(Icons.calendar_today_rounded)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {
                          if (textEditingController.text.isNotEmpty &&
                              dateTime != null) {
                            context.read<BirthdaysBloc>().add(AddBirthdayEvent(
                                name: textEditingController.text,
                                date: dateTime!));
                          }
                        },
                        child: const Text("Add")),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
