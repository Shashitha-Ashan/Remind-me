import 'package:birth_daily/repositories/birthdays/birthday_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/birthday/birthday_model.dart';

part 'birthdays_event.dart';
part 'birthdays_state.dart';

class BirthdaysBloc extends Bloc<BirthdaysEvent, BirthdaysState> {
  final BirthdayRepo _birthdayRepo;
  BirthdaysBloc(this._birthdayRepo) : super(BirthdaysInitial()) {
    on<BirthdaysEvent>((event, emit) async {
      if (event is LoadEvent) {
        emit(LoadingState());
        try {
          final birthdays = await _birthdayRepo.loadBirthdays();
          emit(SuccessLoadState(birthdayModel: birthdays));
        } catch (e) {
          emit(FailedLoadState(error: "Error occured"));
        }
      }
    });
  }
}
