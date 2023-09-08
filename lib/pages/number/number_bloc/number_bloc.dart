import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/api/api.dart';
import 'package:task_flutter/models/number_model.dart';

part 'number_event.dart';
part 'number_state.dart';

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  NumberBloc() : super(NumberLoadingState()) {
    on<NumberInitEvent>(_onNumberPage);
  }
  _onNumberPage(NumberInitEvent event, Emitter<NumberState> emit) async {
    ApiHotel hotel = ApiHotel();

    try {
      final hotelDetail = await hotel.fetchNumber();
      emit(NumberLoadedState(hotelDetail: hotelDetail));
    } catch (e) {
      emit(NumberFailureException(e));
    }
  }
}
