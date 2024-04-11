import 'agify_api_client.dart';
import 'models/age_estimate.dart';
import 'models/estimation_failure.dart';

/// This repository serves as an interface to abstract the data provider.
class AgeEstimationRepository {
  static const _api = AgifyApiClient();

  const AgeEstimationRepository();

  /// Estimates the age of a person by name.
  ///
  /// Throws an [EstimationFailure] when the request or parsing fails.
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
