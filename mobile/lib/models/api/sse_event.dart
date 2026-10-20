import 'package:equatable/equatable.dart';

class const SseEvent({
  required final String event,
  required final String data,
  final String? id,
}) extends Equatable {
  @override
  String toString() => 'SseEvent(id: $id, event: $event, data: $data)';

  @override
  List<Object?> get props => [event, data, id];
}
