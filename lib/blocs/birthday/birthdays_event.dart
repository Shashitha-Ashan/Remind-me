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

class BirthdayProfileEvent extends BirthdayEvent {
  final String docId;

  BirthdayProfileEvent({required this.docId});
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

class AddBirthdayClickEvent extends BirthdayEvent {}
// form events

class BirthdayNameUpdatedEvent extends BirthdayEvent {
  final String name;

  BirthdayNameUpdatedEvent({required this.name});
}

class BirthdayDateUpdatedEvent extends BirthdayEvent {
  final Timestamp date;

  BirthdayDateUpdatedEvent({required this.date});
}

class BirthdayLovingOneUpdatedEvent extends BirthdayEvent {
  final bool isLovingOne;

  BirthdayLovingOneUpdatedEvent({required this.isLovingOne});
}

class BirthdayImageUpdatedEvent extends BirthdayEvent {
  final String imageURL;

  BirthdayImageUpdatedEvent({required this.imageURL});
}

class BirthdayEditAccessEvent extends BirthdayEvent {
  final bool editAccess;

  BirthdayEditAccessEvent({required this.editAccess});
}
