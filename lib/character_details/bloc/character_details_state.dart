part of 'character_details_bloc.dart';

enum CharacterDetailsStatus { initial, success, failure }

class CharacterDetailsState {
  const CharacterDetailsState({
    this.status = CharacterDetailsStatus.initial,
    this.character,
    required this.id,
  });

  final CharacterDetailsStatus status;
  final CharacterDetails? character;
  final String id;
}
