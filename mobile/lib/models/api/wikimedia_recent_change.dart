import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wikimedia_recent_change.g.dart';

@JsonSerializable()
class const WikimediaRecentChange({
  final String? title,
  @JsonKey(name: r'$schema') required final String schema,
  final String? type,
  final bool? bot,
  final String? comment,
  final int? id,
  final WikimediaRecentChangeLength? length,
  @JsonKey(name: 'log_action') final String? logAction,
  @JsonKey(name: 'log_action_comment') final String? logActionComment,
  @JsonKey(name: 'log_id') final int? logId,
  @JsonKey(name: 'log_params') final dynamic logParams,
  @JsonKey(name: 'log_type') final String? logType,
  required final WikimediaRecentChangeMeta meta,
  final bool? minor,
  final int? namespace,
  final String? parsedcomment,
  final bool? patrolled,
  final WikimediaRecentChangeRevision? revision,
  @JsonKey(name: 'server_name') final String? serverName,
  @JsonKey(name: 'server_script_path') final String? serverScriptPath,
  @JsonKey(name: 'server_url') final String? serverUrl,
  final int? timestamp,
  final String? user,
  final String? wiki,
}) extends Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeToJson(this);

  @override
  List<Object?> get props => [
    title,
    schema,
    type,
    bot,
    comment,
    id,
    length,
    logAction,
    logActionComment,
    logId,
    logParams,
    logType,
    meta,
    minor,
    namespace,
    parsedcomment,
    patrolled,
    revision,
    serverName,
    serverScriptPath,
    serverUrl,
    timestamp,
    user,
    wiki,
  ];
}

@JsonSerializable()
class const WikimediaRecentChangeMeta({
  final String? domain,
  required final String dt,
  final String? id,
  @JsonKey(name: 'request_id') final String? requestId,
  required final String stream,
  final String? uri,
}) extends Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeMetaFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeMetaToJson(this);

  @override
  List<Object?> get props => [domain, dt, id, requestId, stream, uri];
}

@JsonSerializable()
class const WikimediaRecentChangeLength({
  @JsonKey(name: 'new') final int? newLength,
  @JsonKey(name: 'old') final int? oldLength,
}) extends Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeLengthFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeLengthToJson(this);

  @override
  List<Object?> get props => [newLength, oldLength];
}

@JsonSerializable()
class const WikimediaRecentChangeRevision({
  @JsonKey(name: 'new') final int? newRevision,
  @JsonKey(name: 'old') final int? oldRevision,
}) extends Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeRevisionFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeRevisionToJson(this);

  @override
  List<Object?> get props => [newRevision, oldRevision];
}
