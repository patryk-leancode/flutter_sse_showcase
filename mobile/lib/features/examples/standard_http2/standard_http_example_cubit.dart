import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_sse_showcase/features/examples/standard_http2/standard_http_example_state.dart';
import 'package:flutter_sse_showcase/models/api/sse_event.dart';
import 'package:flutter_sse_showcase/services/sse_service/sse_service.dart';

class StandardHttpExampleCubit2({required final SseService _sseService})
    extends Cubit<StandardHttpExampleState2> {
  this : super(const StandardHttpExampleInitial());

  StreamSubscription<SseEvent>? _streamSubscription;

  Future<void> startStreaming() async {
    await _streamSubscription?.cancel();

    try {
      emit(const StandardHttpExampleLoading());

      final numbers = <String>[];

      _streamSubscription = _sseService.streamNumbers().listen(
        (sseEvent) {
          numbers.add(sseEvent.data);
          emit(StandardHttpExampleReceivingData(numbers: List.from(numbers)));
        },
        onError: (Object error) {
          emit(StandardHttpExampleError(message: error.toString()));
        },
        onDone: () {
          if (state is StandardHttpExampleError) {
            return;
          }
          emit(StandardHttpExampleCompleted(numbers: List.from(numbers)));
        },
        cancelOnError: false,
      );
    } catch (error) {
      emit(StandardHttpExampleError(message: error.toString()));
    }
  }

  Future<void> refreshData() async {
    await startStreaming();
  }

  void clearData() {
    emit(const StandardHttpExampleInitial());
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
