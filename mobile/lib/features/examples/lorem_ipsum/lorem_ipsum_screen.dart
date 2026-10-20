import 'package:flutter/material.dart';
import 'package:flutter_lean_di_bloc/flutter_lean_di_bloc.dart';
import 'package:flutter_sse_showcase/features/examples/lorem_ipsum/lorem_ipsum_cubit.dart';
import 'package:flutter_sse_showcase/features/examples/lorem_ipsum/lorem_ipsum_state.dart';
import 'package:flutter_sse_showcase/services/sse_service/sse_service.dart';
import 'package:flutter_sse_showcase/widgets/standard_app_bar.dart';

class const LoremIpsumScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DepsProvider(
      register: [
        BlocDependency<LoremIpsumCubit>(
          (deps, _) =>
              LoremIpsumCubit(sseService: deps.get<SseService>())
                ..startStreaming(),
        ),
      ],
      child: const Scaffold(
        appBar: StandardAppBar(title: 'Lorem Ipsum Stream'),
        body: SafeArea(child: _LoremIpsumContent()),
      ),
    );
  }
}

class const _LoremIpsumContent() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoremIpsumCubit, LoremIpsumState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _LoremIpsumStateContent(state: state)),
              if (state is LoremIpsumCompleted)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      context.get<LoremIpsumCubit>().refreshData();
                    },
                    child: const Text('Refresh'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class const _LoremIpsumStateContent({required final LoremIpsumState state})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return switch (state) {
      LoremIpsumInitial() => const Center(
        child: Text(
          'Ready to start streaming...',
          style: TextStyle(fontSize: 18),
        ),
      ),
      LoremIpsumLoading() => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Connecting to stream...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      LoremIpsumReceivingData(
        :final text,
        :final charactersSent,
        :final charactersRemaining,
      ) =>
        _TextStreamView(
          text: text,
          charactersSent: charactersSent,
          charactersRemaining: charactersRemaining,
          isCompleted: false,
        ),
      LoremIpsumCompleted(:final text, :final charactersSent) =>
        _TextStreamView(
          text: text,
          charactersSent: charactersSent,
          charactersRemaining: 0,
          isCompleted: true,
        ),
      LoremIpsumError(:final message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Error occurred:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.get<LoremIpsumCubit>().refreshData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    };
  }
}

class const _TextStreamView({
  required final String text,
  required final int charactersSent,
  required final int charactersRemaining,
  required final bool isCompleted,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final total = charactersSent + charactersRemaining;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[50],
            ),
            child: SingleChildScrollView(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green[50] : Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isCompleted ? Colors.green : Colors.blue,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.downloading,
                color: isCompleted ? Colors.green : Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                '$charactersSent / $total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.green[900] : Colors.blue[900],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
