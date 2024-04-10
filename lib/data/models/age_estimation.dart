import 'package:equatable/equatable.dart';

class AgeEstimation extends Equatable {
  final String name;
  final int age;

  const AgeEstimation({required this.name, required this.age});

  @override
  List<Object> get props => [name, age];
}
