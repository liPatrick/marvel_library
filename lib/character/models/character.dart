import 'package:equatable/equatable.dart';
import 'dart:convert';
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

  static Character fromJson(Map<String, dynamic> json) {
    List<Comic>? decodedComics;
    if (jsonDecode(json['comics']) != null) {
      decodedComics = List<Comic>.from(
          jsonDecode(json['comics']).map((i) => Comic.fromJson(i)));
    } else {
      decodedComics = null;
    }

    return Character(
      name: json['name'],
      id: json['id'],
      description: json['description'],
      thumbnailPath: json['thumbnailPath'],
      thumbnailExtension: json['thumbnailExtension'],
      comics: decodedComics,
      loaded: json['loaded'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'description': description,
        'thumbnailPath': thumbnailPath,
        'thumbnailExtension': thumbnailExtension,
        'comics': jsonEncode(comics),
        'loaded': loaded,
      };
}
