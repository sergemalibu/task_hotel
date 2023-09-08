import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/api/api.dart';
import 'package:task_flutter/models/hotel_model.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(HotelLoadingState()) {
    on<HotelInitEvent>(_onHotelPage);
  }

  _onHotelPage(HotelInitEvent event, Emitter<HotelState> emit) async {
    ApiHotel hotel = ApiHotel();

    try {
      final listHotel = await hotel.fetchHotel();
      emit(HotelLoadedState(hotelList: listHotel));
    } catch (e) {
      emit(HotelFailureException(e));
    }
  }
}
