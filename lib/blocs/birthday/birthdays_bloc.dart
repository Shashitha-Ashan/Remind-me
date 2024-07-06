import 'package:birth_daily/repositories/birthdays/birthday_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'package:birth_daily/models/birthday/birthday_model.dart';

part 'birthdays_event.dart';
part 'birthdays_state.dart';

class BirthdaysBloc extends Bloc<BirthdayEvent, BirthdayState> {
  final BirthdayRepo _birthdayRepo;
  BirthdaysBloc(this._birthdayRepo) : super(BirthdaysInitial()) {
    on<BirthdayEvent>((event, emit) async {
      // if (event is LoadBirthdaysEvent) {
      //   emit(BirthdaysLoadingState());
      //   try {
      //     final birthdays = await _birthdayRepo.loadBirthdays();
      //     emit(BirthdaysSuccessLoadState(birthdays: birthdays));
      //   } catch (e) {
      //     emit(BirthdaysFailedLoadState(message: "Error occured"));
      //   }
      // }
      if (event is AddBirthdayEvent) {
        try {
          await _birthdayRepo.addBirthday(
              name: event.name,
              date: event.date,
              imageURL: event.imageURL,
              isLovingOne: event.isLovingOne);
          emit(BirthdayAdded());
        } catch (e) {
          emit(BirthdayAddError());
        }
      }
      if (event is UpdateBirthdayEvent) {
        try {
          await _birthdayRepo.updateBirthday(
              name: event.name,
              date: event.date,
              docId: event.id,
              imageURL: event.imageURL,
              isLovingOne: event.isLovingOne);
          emit(BirthdayUpdated());
        } catch (e) {
          emit(BirthdayUpdateError());
        }
      }
      if (event is DeleteBirthdayEvent) {
        try {
          await _birthdayRepo.deleteBirthday(docId: event.id);
          emit(BirthdayDeleted());
        } catch (e) {
          emit(BirthdayDeleteError());
        }
      }
      if (event is BirthdayProfileEvent) {
        try {
          final BirthdayModel? res =
              await _birthdayRepo.getBirthdayById(docId: event.docId);
          emit(BirthdayProfileState(
              docId: res!.id,
              date: res.dateTime,
              name: res.name,
              imageURL: res.imageURL,
              isLovingOne: res.isLovingOne));
        } catch (e) {}
      }

      if (event is BirthdayEditAccessEvent) {
        emit(BirthdayEditAccessState(editAccess: event.editAccess));
      }
      if (event is BirthdayNameUpdatedEvent) {
        emit(BirthdayNameUpdatedState(name: event.name));
      }
      if (event is BirthdayDateUpdatedEvent) {
        emit(BirthdayDateUpdatedState(date: event.date));
      }
      if (event is BirthdayLovingOneUpdatedEvent) {
        emit(BirthdayLovingOneUpdatedState(isLovingOne: event.isLovingOne));
      }
      if (event is BirthdayImageUpdatedEvent) {
        emit(BirthdayImageUpdatedState(imageURL: event.imageURL));
      }
    });
  }
}
