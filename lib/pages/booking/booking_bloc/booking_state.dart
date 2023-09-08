part of 'booking_bloc.dart';

class BookingState {}

class BookingLoadingState extends BookingState {}

class BookingLoadedState extends BookingState {
  final BookingModel booking;

  BookingLoadedState({required this.booking});
}

class BookingFailureException extends BookingState {
  final Object? exception;

  BookingFailureException(this.exception);
}
