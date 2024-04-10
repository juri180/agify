import 'agify_api_client.dart';
import 'models/age_estimate.dart';

class AgeEstimationRepository {
  static const _api = AgifyApi();

  const AgeEstimationRepository();

  Future<AgeEstimate?> estimateAge(String name) async {
    final bodyJson = await _api.requestAgeEstimate(name);

    if (bodyJson != null) {
      return AgeEstimate(name: bodyJson['name'], age: bodyJson['age']);
    }

    return null;
  }
}
