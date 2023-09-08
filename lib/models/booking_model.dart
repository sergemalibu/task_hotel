import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  int? id;
  String? hotelName;
  String? hotelAdress;
  int? horating;
  String? ratingName;
  String? departure;
  String? arrivalCountry;
  String? tourDateStart;
  String? tourDateStop;
  int? numberOfNights;
  String? room;
  String? nutrition;
  int? tourPrice;
  int? fuelCharge;
  int? serviceCharge;

  BookingModel(
      {this.id,
      this.hotelName,
      this.hotelAdress,
      this.horating,
      this.ratingName,
      this.departure,
      this.arrivalCountry,
      this.tourDateStart,
      this.tourDateStop,
      this.numberOfNights,
      this.room,
      this.nutrition,
      this.tourPrice,
      this.fuelCharge,
      this.serviceCharge});

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}
