import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:marvel_library/character/character.dart';
import 'package:http/http.dart' as http;

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc({required this.httpClient}) : super(CharacterState());
  final http.Client httpClient;

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    print('char length:' + state.characters.length.toString());
    if (event is CharacterListFetched) {
      if (state.characters.length != 0) {
      } else {
        yield await _mapCharacterListFetchedToState(state);
      }
    } else if (event is CharacterSelected) {
      yield state.copyWith(
          status: CharacterStatus.initial,
          selectedCharacter: event.character,
          characters: state.characters);
      if (event.character.loaded == true) {
        yield state.copyWith(
          status: CharacterStatus.success,
          selectedCharacter: event.character,
          characters: state.characters,
        );
      } else {
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
      character.loaded = true;
      return CharacterState(
        status: CharacterStatus.success,
        characters: state.characters,
        selectedCharacter: character,
      );
    } on Exception {
      return CharacterState(
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
        status: CharacterStatus.failure,
      );
    }
  }
}
