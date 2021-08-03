import 'dart:ffi';

import 'package:equatable/equatable.dart';

import 'models.dart';

class Character extends Equatable {
  const Character({
    required this.id,
    required this.name,
    this.description,
    this.thumbnailPath,
    this.thumbnailExtension,
    this.comics,
  });

  final int id;
  final String name;
  final String? description;
  final String? thumbnailPath;
  final String? thumbnailExtension;
  final List<Comic>? comics;

  @override
  List<Object?> get props => [];
}
