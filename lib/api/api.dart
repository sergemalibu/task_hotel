import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_flutter/models/booking_model.dart';
import 'package:task_flutter/models/hotel_model.dart';
import 'package:task_flutter/models/number_model.dart';

class ApiHotel {
  Future<HotelModel> fetchHotel() async {
    final response = await http.get(Uri.parse(
        "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"));

    final hotel = HotelModel.fromJson(json.decode(response.body));

    return hotel;
  }

  Future<NumberModel> fetchNumber() async {
    final response = await http.get(Uri.parse(
        "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd"));

    final hotel = NumberModel.fromJson(json.decode(response.body));

    return hotel;
  }

  Future<BookingModel> fetchBooking() async {
    final response = await http.get(Uri.parse(
        "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"));

    final booking = BookingModel.fromJson(json.decode(response.body));

    return booking;
  }
}
