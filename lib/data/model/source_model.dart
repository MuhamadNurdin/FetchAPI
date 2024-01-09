// source_model.dart
import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String name;
  final String description;

  const Source({
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [name, description];
}
