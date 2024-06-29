import 'package:birth_daily/repositories/birthdays/birthday_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:birth_daily/models/birthday/birthday_model.dart';

part 'birthdays_event.dart';
part 'birthdays_state.dart';

class BirthdaysBloc extends Bloc<BirthdayEvent, BirthdayState> {
  final BirthdayRepo _birthdayRepo;
  BirthdaysBloc(this._birthdayRepo) : super(BirthdaysInitial()) {
    on<BirthdayEvent>((event, emit) async {
      if (event is LoadBirthdaysEvent) {
        emit(BirthdaysLoadingState());
        try {
          final birthdays = await _birthdayRepo.loadBirthdays();
          emit(BirthdaysSuccessLoadState(birthdays: birthdays));
        } catch (e) {
          emit(BirthdaysFailedLoadState(message: "Error occured"));
        }
      }
      if (event is AddBirthdayEvent) {
        try {
          await _birthdayRepo.addBirthday(name: event.name, date: event.date);
          emit(BirthdayAdded());
          add(LoadBirthdaysEvent());
        } catch (e) {
          emit(BirthdayAddError());
        }
      }
      if (event is UpdateBirthdayEvent) {
        try {
          await _birthdayRepo.updateBirthday(
              name: event.name, date: event.date, docId: event.id);
          emit(BirthdayUpdated());
          add(LoadBirthdaysEvent());
        } catch (e) {
          emit(BirthdayUpdateError());
        }
      }
      if (event is DeleteBirthdayEvent) {
        try {
          await _birthdayRepo.deleteBirthday(docId: event.id);
          emit(BirthdayDeleted());
          add(LoadBirthdaysEvent());
        } catch (e) {
          emit(BirthdayDeleteError());
        }
      }
    });
  }
}
