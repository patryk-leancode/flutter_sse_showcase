import 'package:equatable/equatable.dart';
import 'package:flutter_sse_showcase/features/examples/wikimedia/wikimedia_change_item.dart';

sealed class const WikimediaState() with Equatable {
  @override
  List<Object?> get props => [];
}

class const WikimediaInitial() extends WikimediaState;

class const WikimediaReceivingData({
  required final List<WikimediaChangeItem> events,
}) extends WikimediaState {
  @override
  List<Object?> get props => [events];
}

class const WikimediaStopped({required final List<WikimediaChangeItem> events})
    extends WikimediaState {
  @override
  List<Object?> get props => [events];
}

class const WikimediaError({required final String message})
    extends WikimediaState {
  @override
  List<Object?> get props => [message];
}
