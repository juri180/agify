import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/age_estimation_repository.dart';
import '../data/models/age_estimate.dart';
import '../data/models/estimation_failure.dart';

part 'age_estimation_state.dart';

class AgeEstimationCubit extends Cubit<AgeEstimationState> {
  final AgeEstimationRepository _repository;

  AgeEstimationCubit({AgeEstimationRepository? repository})
      : _repository = repository ?? AgeEstimationRepository(),
        super(AgeEstimationInitial());

  Future<void> onNameSubmitted(String name) async {
    emit(AgeEstimationLoading());

    AgeEstimate result;
    try {
      result = await _repository.estimateAge(name);
    } on EstimationFailure catch (failure) {
      emit(AgeEstimationFailed(failure));
      return;
    }

    emit(AgeEstimationSuccessful(result));
  }
}
