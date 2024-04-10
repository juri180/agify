part of 'age_estimation_cubit.dart';

sealed class AgeEstimationState extends Equatable {
  const AgeEstimationState();

  @override
  List<Object> get props => [];
}

final class AgeEstimationInitial extends AgeEstimationState {}

final class AgeEstimationLoading extends AgeEstimationState {}

final class AgeEstimationSuccessful extends AgeEstimationState {
  final AgeEstimation estimation;

  const AgeEstimationSuccessful(this.estimation);

  @override
  List<Object> get props => [estimation];
}

final class AgeEstimationFailed extends AgeEstimationState {}
