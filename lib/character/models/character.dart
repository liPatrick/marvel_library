import 'package:equatable/equatable.dart';

class Character extends Equatable {
  Character({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [];

  static Character fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
