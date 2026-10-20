import 'package:flutter/material.dart';
import 'package:flutter_lean_di/flutter_lean_di.dart';
import 'package:flutter_sse_showcase/features/clients/clients.dart';
import 'package:flutter_sse_showcase/services/sse_service/sse_service.dart';
import 'package:flutter_sse_showcase/utils/sse_client/eventflux_client.dart';
import 'package:flutter_sse_showcase/utils/sse_client/flutter_client_sse.dart';
import 'package:flutter_sse_showcase/utils/sse_client/sse_channel_client.dart';
import 'package:flutter_sse_showcase/utils/sse_client/sse_client.dart';
import 'package:flutter_sse_showcase/utils/sse_client/sse_simple_client.dart';
import 'package:http/http.dart' as http;

class const ClientDependencies({
  super.key,
  required final Clients client,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DepsProvider(
      register: [
        Dependency<http.Client>(
          (deps, _) => http.Client(),
          dispose: (client) => client.close(),
        ),
        Dependency<SseClient>(
          (deps, _) => switch (client) {
            .simple => SseSimpleClient(deps.get<http.Client>()),
            .flutterClientSse => FlutterClientSse(),
            .eventflux => EventfluxClient(),
            .sseChannel => SseChannelClient(),
          },
          cacheKey: client,
        ),
        Dependency<SseService>(
          (deps, _) => SseService(deps.get<SseClient>()),
          cacheKey: client,
        ),
      ],
      child: child,
    );
  }
}
