import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/age_estimation_cubit.dart';

class EstimationResult extends StatelessWidget {
  const EstimationResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeEstimationCubit, AgeEstimationState>(
      builder: (context, state) {
        if (state is AgeEstimationSuccessful) {
          return Text(
            '${state.estimate.name} is ${state.estimate.age} years old',
            style: Theme.of(context).textTheme.bodyLarge,
          );
        } else if (state is AgeEstimationFailed) {
          return const Text(
            'Estimation failed. Please check your network status and try '
            'again.',
          );
        } else if (state is AgeEstimationLoading) {
          return const CircularProgressIndicator();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
