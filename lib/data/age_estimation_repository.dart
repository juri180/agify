import 'agify_api_client.dart';
import 'models/age_estimate.dart';
import 'models/estimation_failure.dart';

class AgeEstimationRepository {
  static const _api = AgifyApiClient();

  const AgeEstimationRepository();

  Future<AgeEstimate> estimateAge(String name) async {
    final json = await _api.requestAgeEstimate(name);

    try {
      return AgeEstimate.fromJson(json);
    } on TypeError {
      throw const EstimationFailure(
        'Bad response format. Please report this error.',
      );
    }
  }
}
