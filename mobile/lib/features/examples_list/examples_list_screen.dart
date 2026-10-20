import 'package:flutter/material.dart';
import 'package:flutter_sse_showcase/features/examples/lorem_ipsum/lorem_ipsum_screen.dart';
import 'package:flutter_sse_showcase/features/examples/shapes_and_colors/shapes_and_colors_screen.dart';
import 'package:flutter_sse_showcase/features/examples/standard_http/standard_http_example_screen.dart';
import 'package:flutter_sse_showcase/features/examples/standard_http2/standard_http_example_screen.dart';
import 'package:flutter_sse_showcase/features/examples/wikimedia/wikimedia_screen.dart';
import 'package:flutter_sse_showcase/features/examples_list/examples.dart';
import 'package:flutter_sse_showcase/widgets/standard_app_bar.dart';
import 'package:flutter_sse_showcase/widgets/standard_list_tile.dart';

class const ExamplesListScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onExampleTap(Examples example) {
      switch (example) {
        case Examples.standardHttp:
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const StandardHttpExampleScreen(),
            ),
          );
        case Examples.standardHttp2:
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const StandardHttpExampleScreen2(),
            ),
          );
        case Examples.loremIpsum:
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const LoremIpsumScreen(),
            ),
          );
        case Examples.shapesAndColors:
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const ShapesAndColorsScreen(),
            ),
          );
        case Examples.wikimedia:
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const WikimediaScreen(),
            ),
          );
      }
    }

    return Scaffold(
      appBar: StandardAppBar(
        title: 'SSE Examples',
        leading: BackButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: Examples.values.length,
        itemBuilder: (context, index) {
          final example = Examples.values[index];
          return StandardListTile(
            title: Text(example.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onExampleTap(example),
          );
        },
      ),
    );
  }
}
