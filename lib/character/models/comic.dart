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
}
