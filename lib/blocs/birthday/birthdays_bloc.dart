import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'birthdays_event.dart';
part 'birthdays_state.dart';

class BirthdaysBloc extends Bloc<BirthdaysEvent, BirthdaysState> {
  BirthdaysBloc() : super(BirthdaysInitial()) {
    on<BirthdaysEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
