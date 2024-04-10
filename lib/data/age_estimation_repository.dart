import 'agify_api_client.dart';
import 'models/age_estimation.dart';

class AgeEstimationRepository {
  static const _api = AgifyApi();

  const AgeEstimationRepository();

  Future<AgeEstimation?> requestAgeEstimation(String name) async {
    final bodyJson = await _api.requestAgeEstimation(name);

    if (bodyJson != null) {
      return AgeEstimation(name: bodyJson['name'], age: bodyJson['age']);
    }

    return null;
  }
}
