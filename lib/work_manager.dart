import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';

bool isMidNight(DateTime time) {
  return time.hour == 0 && time.minute == 0;
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (isMidNight(DateTime.now())) {
      await Firebase.initializeApp();
      final User? user = FirebaseAuth.instance.currentUser;

      final today = DateTime.now();
      final todayString =
          "${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

      int birthdayCount = 0;
      final querySnapshot =
          await FirebaseFirestore.instance.collection('birthdays').get();
      for (var doc in querySnapshot.docs) {
        final dateOfBirth = doc['date'];
        final uid = doc['uid'];
        if (dateOfBirth.endsWith(todayString) && user!.uid == uid) {
          birthdayCount++;
        }
      }

      // Update the widget
      await HomeWidget.saveWidgetData(
          'text_from_app', birthdayCount.toString());
      await HomeWidget.updateWidget(
        androidName: 'BirthdayCount',
      );

      return Future.value(true);
    }
    return Future.value(true);
  });
}
