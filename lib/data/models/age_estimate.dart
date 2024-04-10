import 'package:equatable/equatable.dart';

class AgeEstimate extends Equatable {
  final String name;
  final int? age;

  const AgeEstimate({required this.name, required this.age});

  AgeEstimate.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];

  @override
  List<Object?> get props => [name, age];
}
