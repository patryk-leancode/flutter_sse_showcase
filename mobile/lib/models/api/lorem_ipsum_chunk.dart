import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lorem_ipsum_chunk.g.dart';

@JsonSerializable()
class const LoremIpsumChunk({
  required final String chunk,
  @JsonKey(name: 'characters_sent') required final int charactersSent,
  @JsonKey(name: 'characters_remaining') required final int charactersRemaining,
}) extends Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      _$LoremIpsumChunkFromJson(json);

  Map<String, dynamic> toJson() => _$LoremIpsumChunkToJson(this);

  @override
  List<Object?> get props => [chunk, charactersSent, charactersRemaining];
}
