import 'dart:convert';

import 'package:flutter_sse_showcase/models/api/sse_event.dart';
import 'package:flutter_sse_showcase/models/api/sse_event_builder.dart';
import 'package:flutter_sse_showcase/utils/sse_client/sse_client.dart';
import 'package:http/http.dart' as http;

class SseSimpleClient(final http.Client _client) implements SseClient {
  @override
  Stream<SseEvent> stream(http.Request request) async* {
    try {
      final response = await _client.send(request);

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to connect to SSE endpoint: ${response.statusCode}',
        );
      }

      var eventBuilder = SseEventBuilder();

      await for (final line
          in response.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())) {
        if (line.isEmpty) {
          final event = eventBuilder.build();
          if (event != null) {
            yield event;
          }
          eventBuilder = SseEventBuilder();
        }

        final isComment = line.startsWith(':');
        if (isComment) {
          continue;
        }

        eventBuilder.addLine(line);
      }
    } catch (err) {
      throw Exception('SSE streaming error: $err');
    }
  }
}
