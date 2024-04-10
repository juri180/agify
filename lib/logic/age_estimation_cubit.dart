import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/age_estimation_repository.dart';
import '../data/models/age_estimate.dart';

part 'age_estimation_state.dart';

class AgeEstimationCubit extends Cubit<AgeEstimationState> {
  final _repository = const AgeEstimationRepository();

  AgeEstimationCubit() : super(AgeEstimationInitial());

  Future<void> onNameSubmitted(String name) async {
    emit(AgeEstimationLoading());

    final result = await _repository.estimateAge(name);

    if (result == null) {
      emit(AgeEstimationFailed());
    } else {
      emit(AgeEstimationSuccessful(result));
    }
  }
}
