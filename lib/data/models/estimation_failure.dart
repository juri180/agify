import 'package:equatable/equatable.dart';

class EstimationFailure extends Equatable {
  final String description;

  const EstimationFailure(this.description);

  @override
  List<Object> get props => [description];
}
