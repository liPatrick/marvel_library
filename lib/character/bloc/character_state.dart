part of 'character_bloc.dart';

enum CharacterStatus { initial, success, failure }

@immutable
class CharacterState {
  const CharacterState(
      {this.status = CharacterStatus.initial,
      this.characters = const <Character>[],
      this.selectedCharacter});

  final CharacterStatus status;
  final List<Character> characters;
  final Character? selectedCharacter;

  CharacterState copyWith({
    CharacterStatus status = CharacterStatus.initial,
    Character? selectedCharacter,
    List<Character>? characters,
  }) {
    return CharacterState(
      selectedCharacter: selectedCharacter ?? this.selectedCharacter,
      characters: characters ?? this.characters,
    );
  }
}
