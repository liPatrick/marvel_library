import 'package:equatable/equatable.dart';

import 'models.dart';

class Character extends Equatable {
  Character({
    required this.id,
    required this.name,
    this.description = '',
    this.thumbnailPath,
    this.thumbnailExtension,
    this.comics,
    this.loaded = false,
  });

  final int id;
  final String name;
  final String? description;
  final String? thumbnailPath;
  final String? thumbnailExtension;
  final List<Comic>? comics;
  bool loaded;

  @override
  List<Object?> get props => [];

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['email'],
        description = json['description'],
        thumbnailPath = json['thumbnailPath'],
        thumbnailExtension = json['thumbnailExtension'],
        comics = json['comics'],
        loaded = json['loaded'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'description': description,
        'thumbnailPath': thumbnailPath,
        'thumbnailExtension': thumbnailExtension,
        'comics': comics,
        'loaded': loaded,
      };
}
