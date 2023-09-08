part of 'number_bloc.dart';

class NumberState {}

class NumberLoadingState extends NumberState {}

class NumberLoadedState extends NumberState {
  final NumberModel hotelDetail;

  NumberLoadedState({required this.hotelDetail});
}

class NumberFailureException extends NumberState {
  final Object? exception;

  NumberFailureException(this.exception);
}
