import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'color_change_event.g.dart';

@JsonSerializable()
class const ColorChangeEvent({
  required final String color,
  required final String intensity,
}) with Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      _$ColorChangeEventFromJson(json);

  Map<String, dynamic> toJson() => _$ColorChangeEventToJson(this);

  @override
  List<Object?> get props => [color, intensity];
}
