import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/age_estimate.dart';
import '../../logic/age_estimation_cubit.dart';

class EstimationResult extends StatelessWidget {
  const EstimationResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeEstimationCubit, AgeEstimationState>(
      builder: (context, state) {
        if (state is AgeEstimationSuccessful) {
          return Text(
            _successfulEstimationText(state.estimate),
            style: Theme.of(context).textTheme.bodyLarge,
          );
        } else if (state is AgeEstimationFailed) {
          return Text(state.failure.description);
        } else if (state is AgeEstimationLoading) {
          return const CircularProgressIndicator();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  String _successfulEstimationText(AgeEstimate estimate) {
    if (estimate.age == null) {
      return 'Uh oh. ${estimate.name} is unknown to us.';
    }

    return '${estimate.name} is ${estimate.age} years old.';
  }
}
