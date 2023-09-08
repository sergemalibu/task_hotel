// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberModel _$NumberModelFromJson(Map<String, dynamic> json) => NumberModel(
      rooms: (json['rooms'] as List<dynamic>?)
          ?.map((e) => Rooms.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NumberModelToJson(NumberModel instance) =>
    <String, dynamic>{
      'rooms': instance.rooms,
    };

Rooms _$RoomsFromJson(Map<String, dynamic> json) => Rooms(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      pricePer: json['price_per'] as String?,
      peculiarities: (json['peculiarities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RoomsToJson(Rooms instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'pricePer': instance.pricePer,
      'peculiarities': instance.peculiarities,
      'imageUrls': instance.imageUrls,
    };
