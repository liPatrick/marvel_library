import 'dart:async';
import 'dart:convert';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:marvel_library/character_api.dart';
import 'package:meta/meta.dart';
import 'package:marvel_library/character/character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends HydratedBloc<CharacterEvent, CharacterState> {
  CharacterBloc({required this.characterAPI})
      : super(CharacterState(characters: []));
  final CharacterAPI characterAPI;

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is CharacterListFetched) {
      if (state.characters.length != 0) {
        yield CharacterState(
          status: CharacterStatus.success,
          characters: state.characters,
        );
      } else {
        yield await _mapCharacterListFetchedToState(state);
      }
    }
  }

  Future<CharacterState> _mapCharacterListFetchedToState(
      CharacterState state) async {
    try {
      final characters = await characterAPI.fetchAllCharacters();
      return CharacterState(
        status: CharacterStatus.success,
        characters: characters,
      );
    } on Exception {
      return CharacterState(
        status: CharacterStatus.failure,
        characters: state.characters,
      );
    }
  }

  @override
  CharacterState? fromJson(Map<String, dynamic> json) {
    List<Character> decodedCharacters = List<Character>.from(
        jsonDecode(json['characters']).map((i) => Character.fromJson(i)));
    return CharacterState(characters: decodedCharacters);
  }

  @override
  Map<String, dynamic>? toJson(CharacterState state) {
    return {'characters': jsonEncode(state.characters)};
  }
}
