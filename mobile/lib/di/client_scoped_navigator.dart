import 'package:flutter/material.dart';
import 'package:flutter_sse_showcase/di/client_dependencies.dart';
import 'package:flutter_sse_showcase/features/clients/clients.dart';
import 'package:flutter_sse_showcase/features/examples_list/examples_list_screen.dart';

class const ClientScopedNavigator({super.key, required final Clients client})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClientDependencies(
      client: client,
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const ExamplesListScreen(),
            settings: settings,
          );
        },
      ),
    );
  }
}
