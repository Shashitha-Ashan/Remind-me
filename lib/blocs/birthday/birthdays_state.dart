part of 'birthdays_bloc.dart';

@immutable
sealed class BirthdaysState {}

final class BirthdaysInitial extends BirthdaysState {}

class InitialState extends BirthdaysState {}

class LoadState extends BirthdaysState {}

class SuccessLoadState extends BirthdaysState {}

class FailedLoadState extends BirthdaysState {}
