import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/api/api.dart';
import 'package:task_flutter/models/booking_model.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingLoadingState()) {
    on<BookingInitEvent>(_onBookingPage);
  }

  _onBookingPage(BookingInitEvent event, Emitter<BookingState> emit) async {
    ApiHotel api = ApiHotel();

    try {
      final booking = await api.fetchBooking();
      emit(BookingLoadedState(booking: booking));
    } catch (e) {
      emit(BookingFailureException(e));
    }
  }
}
