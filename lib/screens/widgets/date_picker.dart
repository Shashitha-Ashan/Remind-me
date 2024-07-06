import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<DateTime?> showBirthdatePicker({required BuildContext context}) async {
  return await showDatePicker(
    keyboardType: TextInputType.datetime,
    initialDatePickerMode: DatePickerMode.day,
    initialEntryMode: DatePickerEntryMode.calendar,
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
}
