import 'dart:async';

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:marvel_library/character/character.dart';
import 'package:http/http.dart' as http;

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends HydratedBloc<CharacterEvent, CharacterState> {
  CharacterBloc({required this.httpClient})
      : super(CharacterState(characters: []));
  final http.Client httpClient;

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    print('char length:' + state.characters.length.toString());
    if (event is CharacterListFetched) {
      if (state.characters.length != 0) {
        yield CharacterState(
          status: CharacterStatus.success,
          selectedCharacter: null,
          characters: state.characters,
        );
      } else {
        yield await _mapCharacterListFetchedToState(state);
      }
    } else if (event is CharacterSelected) {
      print(event.character.loaded);
      if (event.character.loaded == true) {
        yield CharacterState(
          status: CharacterStatus.success,
          selectedCharacter: event.character,
          characters: state.characters,
        );
      } else {
        yield CharacterState(
            status: CharacterStatus.initial,
            selectedCharacter: event.character,
            characters: state.characters);
        yield await _mapCharacterDetailsFetchedToState(event);
      }
    } else if (event is CharacterDeselected) {
      yield CharacterState(
          characters: state.characters,
          selectedCharacter: null,
          status: CharacterStatus.success);
    }
  }

  Future<CharacterState> _mapCharacterDetailsFetchedToState(
      CharacterSelected event) async {
    try {
      final character = await CharacterAPI(httpClient: httpClient)
          .fetchCharacterDetails(event.character.id.toString());
      for (int i = 0; i < state.characters.length; i++) {
        if (state.characters[i].id == character.id) {
          state.characters[i] = character;
          state.characters[i].loaded = true;
        }
      }
      return CharacterState(
        status: CharacterStatus.success,
        characters: state.characters,
        selectedCharacter: character,
      );
    } on Exception {
      return CharacterState(
        characters: state.characters,
        status: CharacterStatus.failure,
      );
    }
  }

  Future<CharacterState> _mapCharacterListFetchedToState(
      CharacterState state) async {
    try {
      final characters =
          await CharacterAPI(httpClient: httpClient).fetchAllCharacters();
      return CharacterState(
        status: CharacterStatus.success,
        characters: characters,
      );
    } on Exception {
      return CharacterState(
        characters: state.characters,
        status: CharacterStatus.failure,
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
