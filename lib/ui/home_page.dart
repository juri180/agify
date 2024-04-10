import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/age_estimation_cubit.dart';
import 'widgets/estimation_result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: BlocProvider<AgeEstimationCubit>(
              create: (_) => AgeEstimationCubit(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        'Estimate the Age\nof a Name',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'First or full name',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<AgeEstimationCubit, AgeEstimationState>(
                        builder: (context, state) {
                          return IconButton.filled(
                            onPressed: state is AgeEstimationLoading
                                ? null
                                : () {
                                    context
                                        .read<AgeEstimationCubit>()
                                        .onNameSubmitted(_nameController.text);
                                  },
                            icon: const Icon(Icons.search),
                          );
                        },
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: EstimationResult(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
