import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_options.freezed.dart'; // Include this for Freezed
part 'main_options.g.dart'; // Include this for JSON serialization

@unfreezed
class MainOptionsClass with _$MainOptionsClass {
  factory MainOptionsClass({
    @Default([]) List<String> bodyType,
    @Default([]) List<String> transmission,
    @Default([]) List<String> engine,
    @Default([]) List<String> drives,
    @Default([]) List<String> steeringWheel,
    @Default([]) List<String> seatsCount,
    @Default("") String engineVolumeStart,
    @Default("") String engineVolumeEnd,
    @Default("") String yearStart,
    @Default("") String yearEnd,
    @Default("") String powerStart,
    @Default("") String powerEnd,
  }) = _MainOptionsClass;

  factory MainOptionsClass.fromJson(Map<String, dynamic> json) =>
      _$MainOptionsClassFromJson(json);
}
