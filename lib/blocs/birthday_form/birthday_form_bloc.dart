import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'birthday_form_event.dart';
part 'birthday_form_state.dart';

class BirthdayFormBloc extends Bloc<BirthdayFormEvent, BirthdayFormState> {
  BirthdayFormBloc() : super(BirthdayFormInitial()) {
    on<BirthdayFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
