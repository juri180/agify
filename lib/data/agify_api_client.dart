import 'dart:convert';

import 'package:http/http.dart' as http;

class AgifyApiClient {
  static const _baseUrl = 'api.agify.io';

  const AgifyApiClient();

  Future<Map<String, dynamic>?> requestAgeEstimate(String name) async {
    final request = Uri.https(_baseUrl, '', {'name': name});

    final response = await http.get(request);

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    }

    return null;
  }
}
