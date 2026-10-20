import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shape_change_event.g.dart';

@JsonSerializable()
class const ShapeChangeEvent({
  required final String shape,
  required final int size,
}) extends Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      _$ShapeChangeEventFromJson(json);

  Map<String, dynamic> toJson() => _$ShapeChangeEventToJson(this);

  @override
  List<Object?> get props => [shape, size];
}
