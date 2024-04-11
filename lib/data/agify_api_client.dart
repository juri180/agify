import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/estimation_failure.dart';

class AgifyApiClient {
  static const _baseUrl = 'api.agify.io';

  const AgifyApiClient();

  Future<Map<String, dynamic>> requestAgeEstimate(String name) async {
    final request = Uri.https(_baseUrl, '', {'name': name});

    http.Response response;
    try {
      response = await http.get(request);
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
        return json.decode(utf8.decode(response.bodyBytes));
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
