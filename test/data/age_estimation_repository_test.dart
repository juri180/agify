import 'package:agify/data/age_estimation_repository.dart';
import 'package:agify/data/agify_api_client.dart';
import 'package:agify/data/models/age_estimate.dart';
import 'package:agify/data/models/estimation_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAgifyApiClient extends Mock implements AgifyApiClient {}

class MockAgeEstimate extends Mock implements AgeEstimate {}

void main() {
  group('AgeEstimationRepository', () {
    late AgifyApiClient api;
    late AgeEstimationRepository repository;

    setUp(() {
      api = MockAgifyApiClient();
      repository = AgeEstimationRepository(api: api);
    });

    group('estimateAge', () {
      test('returns correct AgeEstimate instance', () async {
        when(() => api.requestAgeEstimate('John Doe'))
            .thenAnswer((_) async => {'name': 'John Doe', 'age': 73});

        final estimate = await repository.estimateAge('John Doe');

        expect(estimate, const AgeEstimate(name: 'John Doe', age: 73));
      });

      test(
        'throws EstimationFailure when when api returns json with wrong format',
        () {
          when(() => api.requestAgeEstimate('John Doe'))
              .thenAnswer((_) async => {});

          expect(
            () async => await repository.estimateAge('John Doe'),
            throwsA(isA<EstimationFailure>()),
          );
        },
      );
    });
  });
}
