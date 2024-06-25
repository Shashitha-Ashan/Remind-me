import 'package:birth_daily/repositories/birthdays/birthday_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/birthday/birthday_model.dart';

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
          emit(BirthdaysSuccessLoadState(birthdayModel: birthdays));
        } catch (e) {
          emit(BirthdaysFailedLoadState(message: "Error occured"));
        }
      }
    });
  }
}
