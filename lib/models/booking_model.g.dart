// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['id'] as int?,
      hotelName: json['hotel_name'] as String?,
      hotelAdress: json['hotel_adress'] as String?,
      horating: json['horating'] as int?,
      ratingName: json['rating_name'] as String?,
      departure: json['departure'] as String?,
      arrivalCountry: json['arrival_country'] as String?,
      tourDateStart: json['tour_date_start'] as String?,
      tourDateStop: json['tour_date_stop'] as String?,
      numberOfNights: json['number_of_nights'] as int?,
      room: json['room'] as String?,
      nutrition: json['nutrition'] as String?,
      tourPrice: json['tour_price'] as int?,
      fuelCharge: json['fuel_charge'] as int?,
      serviceCharge: json['service_charge'] as int?,
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hotelName': instance.hotelName,
      'hotelAdress': instance.hotelAdress,
      'horating': instance.horating,
      'ratingName': instance.ratingName,
      'departure': instance.departure,
      'arrivalCountry': instance.arrivalCountry,
      'tourDateStart': instance.tourDateStart,
      'tourDateStop': instance.tourDateStop,
      'numberOfNights': instance.numberOfNights,
      'room': instance.room,
      'nutrition': instance.nutrition,
      'tourPrice': instance.tourPrice,
      'fuelCharge': instance.fuelCharge,
      'serviceCharge': instance.serviceCharge,
    };
