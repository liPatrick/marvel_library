part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class CharacterListFetched extends CharacterEvent {}

class CharacterSelected extends CharacterEvent {
  CharacterSelected({required this.character});

  final Character character;
}

class CharacterDeselected extends CharacterEvent {}

class CharacterDetailsFetched extends CharacterEvent {
  CharacterDetailsFetched({required this.character});

  final Character character;
}
