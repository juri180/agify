import 'package:agify/data/models/age_estimate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AgeEstimate', () {
    group('fromJson', () {
      test('returns correct AgeEstimate instance', () {
        final json = {'name': 'John Doe', 'age': 73};

        final result = AgeEstimate.fromJson(json);

        expect(result, const AgeEstimate(name: 'John Doe', age: 73));
      });

      test('returns correct AgeEstimate instance when age is null', () {
        final json = {'name': 'John Doe', 'age': null};

        final result = AgeEstimate.fromJson(json);

        expect(result, const AgeEstimate(name: 'John Doe', age: null));
      });

      test('throws TypeError when json has wrong format', () {
        final json = {'fullName': 'John Doe', 'age': 73};

        expect(() => AgeEstimate.fromJson(json), throwsA(isA<TypeError>()));
      });
    });
  });
}
