part of 'birthdays_bloc.dart';

@immutable
sealed class BirthdayEvent {}

class InitialEvent extends BirthdayEvent {}

class LoadBirthdaysEvent extends BirthdayEvent {}

class AddBirthdayEvent extends BirthdayEvent {
  final String name;
  final DateTime date;
  AddBirthdayEvent({required this.date, required this.name});
}

class DeleteBirthdayEvent extends BirthdayEvent {
  final String id;

  DeleteBirthdayEvent({required this.id});
}

class UpdateBirthdayEvent extends BirthdayEvent {
  final String id;
  final String name;
  final DateTime date;

  UpdateBirthdayEvent(
      {required this.id, required this.name, required this.date});
}
