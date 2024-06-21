part of 'birthdays_bloc.dart';

@immutable
sealed class BirthdaysEvent {}

class InitialEvent extends BirthdaysEvent {}

class LoadEvent extends BirthdaysEvent {}

class SuccessLoadEvent extends BirthdaysEvent {}

class FailedLoadEvent extends BirthdaysEvent {}
