import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  const Comic({
    required this.title,
    required this.id,
    this.description,
    this.thumbnail,
  });

  final String title;
  final int id;
  final String? description;
  final String? thumbnail;

  @override
  List<Object?> get props => [];
}
