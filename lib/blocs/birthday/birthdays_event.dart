part of 'birthdays_bloc.dart';

@immutable
sealed class BirthdayEvent {}

class InitialEvent extends BirthdayEvent {}

class LoadBirthdaysEvent extends BirthdayEvent {}

class AddBirthdayEvent extends BirthdayEvent {
  final String name;
  final Timestamp date;
  final bool isLovingOne;
  final String imageURL;
  AddBirthdayEvent(
      {required this.date,
      required this.name,
      required this.isLovingOne,
      required this.imageURL});
}

class DeleteBirthdayEvent extends BirthdayEvent {
  final String id;

  DeleteBirthdayEvent({required this.id});
}

class AddBirthdayClickEvent extends BirthdayEvent {}

class UpdateBirthdayClickEvent extends BirthdayEvent {
  final String docId;

  UpdateBirthdayClickEvent({required this.docId});
}

class UpdateBirthdayEvent extends BirthdayEvent {
  final String id;
  final String name;
  final Timestamp date;
  final bool isLovingOne;
  final String imageURL;

  UpdateBirthdayEvent(
      {required this.id,
      required this.isLovingOne,
      required this.name,
      required this.date,
      required this.imageURL});
}
