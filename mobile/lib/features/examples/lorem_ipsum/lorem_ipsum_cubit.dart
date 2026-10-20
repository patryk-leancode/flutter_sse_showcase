import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_sse_showcase/features/examples/lorem_ipsum/lorem_ipsum_state.dart';
import 'package:flutter_sse_showcase/models/api/lorem_ipsum_chunk.dart';
import 'package:flutter_sse_showcase/models/api/sse_event.dart';
import 'package:flutter_sse_showcase/services/sse_service/sse_service.dart';

class LoremIpsumCubit({required final SseService _sseService})
    extends Cubit<LoremIpsumState> {
  this : super(const LoremIpsumInitial());

  StreamSubscription<SseEvent>? _streamSubscription;

  Future<void> startStreaming() async {
    await _streamSubscription?.cancel();

    try {
      emit(const LoremIpsumLoading());

      final textBuffer = StringBuffer();

      _streamSubscription = _sseService.streamLoremIpsum().listen(
        (sseEvent) {
          final jsonData = jsonDecode(sseEvent.data) as Map<String, dynamic>;
          final loremIpsumChunk = LoremIpsumChunk.fromJson(jsonData);

          textBuffer.write(loremIpsumChunk.chunk);

          emit(
            LoremIpsumReceivingData(
              text: textBuffer.toString(),
              charactersSent: loremIpsumChunk.charactersSent,
              charactersRemaining: loremIpsumChunk.charactersRemaining,
            ),
          );
        },
        onError: (Object error) {
          emit(LoremIpsumError(message: error.toString()));
        },
        onDone: () {
          if (state is LoremIpsumReceivingData) {
            final currentState = state as LoremIpsumReceivingData;
            emit(
              LoremIpsumCompleted(
                text: currentState.text,
                charactersSent: currentState.charactersSent,
              ),
            );
          }
        },
        cancelOnError: false,
      );
    } catch (err) {
      emit(LoremIpsumError(message: err.toString()));
    }
  }

  Future<void> refreshData() async {
    await startStreaming();
  }

  void clearData() {
    emit(const LoremIpsumInitial());
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
