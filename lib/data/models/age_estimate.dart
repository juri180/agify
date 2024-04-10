import 'package:equatable/equatable.dart';

class AgeEstimate extends Equatable {
  final String name;
  final int? age;

  const AgeEstimate({required this.name, required this.age});

  @override
  List<Object?> get props => [name, age];
}
