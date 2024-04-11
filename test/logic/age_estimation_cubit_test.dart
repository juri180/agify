import 'package:agify/data/age_estimation_repository.dart';
import 'package:agify/data/models/age_estimate.dart';
import 'package:agify/data/models/estimation_failure.dart';
import 'package:agify/logic/age_estimation_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAgeEstimationRepository extends Mock
    implements AgeEstimationRepository {}

class MockAgeEstimate extends Mock implements AgeEstimate {}

class MockEstimationFailure extends Mock implements EstimationFailure {}

void main() {
  group('AgeEstimationCubit', () {
    late AgeEstimate ageEstimate;
    late EstimationFailure estimationFailure;
    late AgeEstimationRepository repository;
    late AgeEstimationCubit cubit;

    setUp(() {
      ageEstimate = MockAgeEstimate();
      estimationFailure = MockEstimationFailure();
      repository = MockAgeEstimationRepository();
      cubit = AgeEstimationCubit(repository: repository);
    });

    test('initial state is correct', () {
      expect(cubit.state, AgeEstimationInitial());
    });

    group('onNameSubmitted', () {
      blocTest(
        'emits AgeEstimationLoading followed by AgeEstimationSuccessful',
        build: () {
          when(() => repository.estimateAge(any()))
              .thenAnswer((_) async => ageEstimate);
          return cubit;
        },
        act: (cubit) async {
          await cubit.onNameSubmitted('John Doe');
        },
        expect: () => [
          AgeEstimationLoading(),
          AgeEstimationSuccessful(ageEstimate),
        ],
      );

      blocTest(
        'emits AgeEstimationLoading followed by AgeEstimationFailed when '
        'repository throws EstimationFailure',
        build: () {
          when(() => repository.estimateAge(any()))
              .thenThrow((estimationFailure));
          return cubit;
        },
        act: (cubit) async {
          await cubit.onNameSubmitted('John Doe');
        },
        expect: () => [
          AgeEstimationLoading(),
          AgeEstimationFailed(estimationFailure),
        ],
      );
    });
  });
}
