import 'package:flutter/material.dart';
import 'package:flutter_sse_showcase/di/client_scoped_navigator.dart';
import 'package:flutter_sse_showcase/features/clients/clients.dart';
import 'package:flutter_sse_showcase/widgets/standard_app_bar.dart';
import 'package:flutter_sse_showcase/widgets/standard_list_tile.dart';

class const ClientsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onClientTap(Clients client) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => ClientScopedNavigator(client: client),
        ),
      );
    }

    return Scaffold(
      appBar: const StandardAppBar(title: 'Select SSE Client'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: Clients.values.length,
        itemBuilder: (context, index) {
          final client = Clients.values[index];
          return StandardListTile(
            title: Text(client.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onClientTap(client),
          );
        },
      ),
    );
  }
}
