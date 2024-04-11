import 'package:equatable/equatable.dart';

class EstimationFailure extends Equatable {
  /// The customer-oriented description of the failure.
  final String description;

  const EstimationFailure(this.description);

  @override
  List<Object> get props => [description];
}
