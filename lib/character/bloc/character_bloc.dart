import 'dart:async';

import 'package:bloc/bloc.dart';
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
    if (event is CharacterListFetched) {
      yield await _mapCharacterListFetchedToState(state);
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
      return CharacterState(status: CharacterStatus.failure);
    }
  }
}
