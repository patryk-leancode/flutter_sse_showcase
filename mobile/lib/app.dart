import 'package:flutter/material.dart';
import 'package:flutter_sse_showcase/features/clients/clients_screen.dart';

class const SseShowcaseApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSE Showcase',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ClientsScreen(),
    );
  }
}
