import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  const Comic({
    required this.id,
    required this.title,
    this.description,
    this.thumbnailPath,
    this.thumbnailExtension,
  });

  final String title;
  final int id;
  final String? description;
  final String? thumbnailPath;
  final String? thumbnailExtension;

  @override
  List<Object?> get props => [];

  Comic.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['email'],
        description = json['description'],
        thumbnailPath = json['thumbnailPath'],
        thumbnailExtension = json['thumbnailExtension'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'description': description,
        'thumbnailPath': thumbnailPath,
        'thumbnailExtension': thumbnailExtension,
      };
}
