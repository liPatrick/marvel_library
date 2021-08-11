part of 'character_bloc.dart';

enum CharacterStatus { initial, success, failure }

@immutable
class CharacterState {
  const CharacterState(
      {this.status = CharacterStatus.initial,
      required this.characters,
      this.selectedCharacter});

  final CharacterStatus status;
  final List<Character> characters;
  final Character? selectedCharacter;
}
