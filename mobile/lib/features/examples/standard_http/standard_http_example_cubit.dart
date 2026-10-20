import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_sse_showcase/features/examples/standard_http/standard_http_example_state.dart';
import 'package:flutter_sse_showcase/utils/api.dart';
import 'package:http/http.dart';

class StandardHttpExampleCubit({required final Client _client})
    extends Cubit<StandardHttpExampleState> {
  this : super(const StandardHttpExampleInitial());

  StreamSubscription<String>? _streamSubscription;

  Future<void> startStreaming() async {
    await _streamSubscription?.cancel();

    try {
      emit(const StandardHttpExampleLoading());

      final numbers = <String>[];

      final request = createNumbersRequest();

      final response = await _client.send(request);

      if (response.statusCode != 200) {
        emit(
          StandardHttpExampleError(
            message: 'Failed to connect: ${response.statusCode}',
          ),
        );
        return;
      }

      _streamSubscription = response.stream
          .transform(utf8.decoder)
          .listen(
            (chunk) {
              numbers.add(chunk);
              emit(
                StandardHttpExampleReceivingData(numbers: List.from(numbers)),
              );
            },
            onError: (Object error) {
              emit(StandardHttpExampleError(message: error.toString()));
            },
            onDone: () {
              emit(StandardHttpExampleCompleted(numbers: numbers));
            },
            cancelOnError: false,
          );
    } catch (err) {
      emit(StandardHttpExampleError(message: err.toString()));
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
