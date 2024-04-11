import 'package:equatable/equatable.dart';

class AgeEstimate extends Equatable {
  /// The first or full name of a person on which the age estimate is based.
  final String name;

  /// The estimated age in years, where `null` indicates that the age could not
  /// be estimated.
  final int? age;

  const AgeEstimate({required this.name, required this.age});

  AgeEstimate.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];

  @override
  List<Object?> get props => [name, age];
}
