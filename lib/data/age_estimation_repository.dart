import 'agify_api_client.dart';
import 'models/age_estimate.dart';

class AgeEstimationRepository {
  static const _api = AgifyApiClient();

  const AgeEstimationRepository();

  Future<AgeEstimate?> estimateAge(String name) async {
    final json = await _api.requestAgeEstimate(name);

    if (json != null) {
      return AgeEstimate.fromJson(json);
    }

    return null;
  }
}
