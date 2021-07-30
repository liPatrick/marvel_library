import 'dart:ffi';

import 'package:equatable/equatable.dart';

import 'models.dart';

class Character extends Equatable {
  const Character({
    required this.id,
    required this.name,
    this.description,
    this.thumbnail,
    this.comics,
  });

  final int id;
  final String name;
  final String? description;
  final String? thumbnail;
  final List<Comic>? comics;

  @override
  List<Object?> get props => [];
}
