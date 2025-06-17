// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MainOptionsClassImpl _$$MainOptionsClassImplFromJson(
        Map<String, dynamic> json) =>
    _$MainOptionsClassImpl(
      bodyType: (json['bodyType'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      transmission: (json['transmission'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      engine: (json['engine'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      drives: (json['drives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      steeringWheel: (json['steeringWheel'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      seatsCount: (json['seatsCount'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      engineVolumeStart: json['engineVolumeStart'] as String? ?? "",
      engineVolumeEnd: json['engineVolumeEnd'] as String? ?? "",
      yearStart: json['yearStart'] as String? ?? "",
      yearEnd: json['yearEnd'] as String? ?? "",
      powerStart: json['powerStart'] as String? ?? "",
      powerEnd: json['powerEnd'] as String? ?? "",
    );

Map<String, dynamic> _$$MainOptionsClassImplToJson(
        _$MainOptionsClassImpl instance) =>
    <String, dynamic>{
      'bodyType': instance.bodyType,
      'transmission': instance.transmission,
      'engine': instance.engine,
      'drives': instance.drives,
      'steeringWheel': instance.steeringWheel,
      'seatsCount': instance.seatsCount,
      'engineVolumeStart': instance.engineVolumeStart,
      'engineVolumeEnd': instance.engineVolumeEnd,
      'yearStart': instance.yearStart,
      'yearEnd': instance.yearEnd,
      'powerStart': instance.powerStart,
      'powerEnd': instance.powerEnd,
    };
