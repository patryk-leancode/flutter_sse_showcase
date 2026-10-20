import 'package:flutter_sse_showcase/models/api/sse_event.dart';
import 'package:http/http.dart' as http;

abstract interface class SseClient() {
  Stream<SseEvent> stream(http.Request request);
}
