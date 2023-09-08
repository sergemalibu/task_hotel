import 'package:flutter_bloc/flutter_bloc.dart';

class TuristBloc extends Bloc<AddTuristEvent, int> {
  TuristBloc() : super(0) {
    on<AddTuristEvent>(_onAddTurist);
  }

  void _onAddTurist(AddTuristEvent event, Emitter<int> emiter) {
    if (state > 2) return;
    emit(state + 1);
  }
}

class AddTuristEvent {}
