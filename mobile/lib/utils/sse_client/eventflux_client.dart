import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eventflux/eventflux.dart';
import 'package:flutter_sse_showcase/models/api/sse_event.dart';
import 'package:flutter_sse_showcase/utils/sse_client/sse_client.dart';
import 'package:http/http.dart' as http;

class EventfluxClient() implements SseClient {
  @override
  Stream<SseEvent> stream(http.Request request) {
    final controller = StreamController<SseEvent>();
    final eventflux = EventFlux.spawn();

    final connectionType = EventFluxConnectionType.values.firstWhereOrNull(
      (e) => e.name == request.method.toLowerCase(),
    );

    if (connectionType == null) {
      controller
        ..addError(Exception('Invalid method: ${request.method}'))
        ..close();
      return controller.stream;
    }

    final url = request.url.toString();
    eventflux.connect(
      connectionType,
      url,
      header: request.headers,
      onSuccessCallback: (response) {
        final stream = response?.stream;
        if (stream == null) {
          controller.close();
          return;
        }

        stream.listen(
          (data) {
            controller.add(
              SseEvent(event: data.event, data: data.data, id: data.id),
            );
          },
          onError: controller.addError,
          onDone: controller.close,
          cancelOnError: false,
        );
      },
      onError: (error) {
        controller
          ..addError(error)
          ..close();
      },
    );

    return controller.stream;
  }
}
