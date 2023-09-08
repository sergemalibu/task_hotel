part of 'hotel_bloc.dart';

class HotelState {}

class HotelLoadingState extends HotelState {}

class HotelLoadedState extends HotelState {
  final HotelModel hotelList;

  HotelLoadedState({required this.hotelList});
}

class HotelFailureException extends HotelState {
  final Object? exception;

  HotelFailureException(this.exception);
}
