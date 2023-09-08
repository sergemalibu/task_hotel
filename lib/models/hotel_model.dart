import 'package:json_annotation/json_annotation.dart';

part 'hotel_model.g.dart';

@JsonSerializable()
class HotelModel {
  int? id;
  String? name;
  String? adress;
  int? minimalPrice;
  String? priceForIt;
  int? rating;
  String? ratingName;
  List<String>? imageUrls;
  AboutTheHotel? aboutTheHotel;

  HotelModel(
      {this.id,
      this.name,
      this.adress,
      this.minimalPrice,
      this.priceForIt,
      this.rating,
      this.ratingName,
      this.imageUrls,
      this.aboutTheHotel});

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);
}

@JsonSerializable()
class AboutTheHotel {
  String? description;
  List<String>? peculiarities;

  AboutTheHotel({this.description, this.peculiarities});

  factory AboutTheHotel.fromJson(Map<String, dynamic> json) =>
      _$AboutTheHotelFromJson(json);
}
