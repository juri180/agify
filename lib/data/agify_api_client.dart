import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/estimation_failure.dart';

class AgifyApiClient {
  static const _baseUrl = 'api.agify.io';

  final http.Client _httpClient;

  AgifyApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Map<String, dynamic>> requestAgeEstimate(String name) async {
    final request = Uri.https(_baseUrl, '', {'name': name});

    http.Response response;
    try {
      response = await _httpClient.get(request);
    } on SocketException {
      throw const EstimationFailure(
        'No internet connection. Please check your connection and try again.',
      );
    }

    return _processResponse(response);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 429:
        throw const EstimationFailure(
          'Request limit reached. Try again tomorrow.',
        );
      default:
        throw EstimationFailure(
          'Failed request. Please report this error. Status code: '
          '${response.statusCode}.',
        );
    }
  }
}
