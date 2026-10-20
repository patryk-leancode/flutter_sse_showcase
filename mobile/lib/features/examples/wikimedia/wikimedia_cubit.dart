import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_sse_showcase/features/examples/wikimedia/wikimedia_change_item.dart';
import 'package:flutter_sse_showcase/features/examples/wikimedia/wikimedia_state.dart';
import 'package:flutter_sse_showcase/models/api/sse_event.dart';
import 'package:flutter_sse_showcase/models/api/wikimedia_recent_change.dart';
import 'package:flutter_sse_showcase/services/sse_service/sse_service.dart';

class WikimediaCubit({required final SseService _sseService})
    extends Cubit<WikimediaState> {
  this : super(const WikimediaInitial());

  StreamSubscription<SseEvent>? _streamSubscription;

  Future<void> startStreaming() async {
    await _streamSubscription?.cancel();

    try {
      emit(const WikimediaReceivingData(events: []));

      _streamSubscription = _sseService.streamWikimediaRecentChanges().listen(
        (sseEvent) {
          final currentState = state;
          if (currentState is WikimediaReceivingData) {
            final jsonData = jsonDecode(sseEvent.data) as Map<String, dynamic>;
            final recentChange = WikimediaRecentChange.fromJson(jsonData);

            if (recentChange.meta.domain == 'en.wikipedia.org') {
              final changeItem = WikimediaChangeItem(
                user: recentChange.user ?? 'Unknown user',
                title: recentChange.title ?? 'Unknown article',
                timestamp: recentChange.timestamp ?? 0,
                comment: recentChange.comment ?? 'No comment',
              );
              final updatedEvents = [...currentState.events, changeItem];
              emit(WikimediaReceivingData(events: updatedEvents));
            }
          }
        },
        onError: (Object error) {
          emit(WikimediaError(message: error.toString()));
        },
        cancelOnError: false,
      );
    } catch (err) {
      emit(WikimediaError(message: err.toString()));
    }
  }

  Future<void> stopStreaming() async {
    final currentState = state;
    if (currentState is WikimediaReceivingData) {
      await _streamSubscription?.cancel();
      _streamSubscription = null;
      emit(WikimediaStopped(events: currentState.events));
    }
  }

  Future<void> restartStreaming() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    await startStreaming();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
