import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../bloc/counter_bloc.dart';
import '../components/counter_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => getIt.get<CounterBloc>()..add(const CounterStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Generation')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state.status == CounterStatus.failure) {
              return Text(state.message);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CounterPanel(
                  value: state.value,
                  onIncrement: () => context
                      .read<CounterBloc>()
                      .add(const CounterIncremented()),
                ),
              ],
            );  
          },
        ),
      ),
    );
  }
}
