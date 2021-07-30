part of 'character_bloc.dart';

enum CharacterStatus { initial, success, failure }

@immutable
class CharacterState {
  const CharacterState({this.characters = const <Character>[]});
  final List<Character> characters;
}
