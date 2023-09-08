import 'package:json_annotation/json_annotation.dart';

part 'number_model.g.dart';

@JsonSerializable()
class NumberModel {
  List<Rooms>? rooms;

  NumberModel({this.rooms});

  factory NumberModel.fromJson(Map<String, dynamic> json) =>
      _$NumberModelFromJson(json);
}

@JsonSerializable()
class Rooms {
  int? id;
  String? name;
  int? price;
  String? pricePer;
  List<String>? peculiarities;
  List<String>? imageUrls;

  Rooms(
      {this.id,
      this.name,
      this.price,
      this.pricePer,
      this.peculiarities,
      this.imageUrls});

  factory Rooms.fromJson(Map<String, dynamic> json) => _$RoomsFromJson(json);
}
