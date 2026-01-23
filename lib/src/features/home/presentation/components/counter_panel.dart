import 'package:flutter/material.dart';

class CounterPanel extends StatelessWidget {
  const CounterPanel({
    super.key,
    required this.value,
    required this.onIncrement,
  });

  final int value;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Counter'),
        Text(
          '$value',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: onIncrement,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

