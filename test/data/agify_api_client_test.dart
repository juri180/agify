import 'dart:io';

import 'package:agify/data/agify_api_client.dart';
import 'package:agify/data/models/estimation_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('AgifyApiClient', () {
    late http.Client httpClient;
    late AgifyApiClient api;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      api = AgifyApiClient(httpClient: httpClient);
    });

    group('requestAgeEstimate', () {
      test('calls correct http get request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        await api.requestAgeEstimate('John Doe');

        verify(() {
          httpClient.get(Uri.https('api.agify.io', '', {'name': 'John Doe'}));
        }).called(1);
      });

      test('returns response body as decoded json', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"name": "John Doe", "age": 73}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final json = await api.requestAgeEstimate('John Doe');

        expect(json, {'name': 'John Doe', 'age': 73});
      });

      test(
        'throws EstimationFailure when http request throws SocketException',
        () {
          when(() => httpClient.get(any()))
              .thenThrow(const SocketException(''));

          expect(
            () async => await api.requestAgeEstimate('John Doe'),
            throwsA(isA<EstimationFailure>()),
          );
        },
      );

      test('throws EstimationFailure when status code is not 200', () {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(401);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          () async => await api.requestAgeEstimate('John Doe'),
          throwsA(isA<EstimationFailure>()),
        );
      });
    });
  });
}
