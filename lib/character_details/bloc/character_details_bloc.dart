import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:marvel_library/character_api.dart';
import 'package:marvel_library/character_details/models/models.dart';

part 'character_details_event.dart';
part 'character_details_state.dart';

class CharacterDetailsBloc
    extends HydratedBloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc({
    required String id,
    required this.characterAPI,
  }) : super(CharacterDetailsState(id: id));

  CharacterAPI characterAPI;

  @override
  String get id => state.id;

  @override
  Stream<CharacterDetailsState> mapEventToState(
    CharacterDetailsEvent event,
  ) async* {
    if (event is CharacterDetailsFetched) {
      if (state.status == CharacterDetailsStatus.success) {
      } else if (state.status == CharacterDetailsStatus.initial) {
        yield await _mapCharacterDetailsFetchedToState();
      }
    }
  }

  Future<CharacterDetailsState> _mapCharacterDetailsFetchedToState() async {
    try {
      final character = await characterAPI.fetchCharacterDetails(id);

      return CharacterDetailsState(
        id: id,
        status: CharacterDetailsStatus.success,
        character: character,
      );
    } on Exception {
      return CharacterDetailsState(
        id: id,
        status: CharacterDetailsStatus.failure,
      );
    }
  }

  @override
  CharacterDetailsState? fromJson(Map<String, dynamic> json) {
    return CharacterDetailsState(
      id: json['id'] as String,
      character: CharacterDetails.fromJson(json['character']),
    );
  }

  @override
  Map<String, dynamic>? toJson(CharacterDetailsState state) {
    return {
      'id': state.id,
      'character': state.character!.toJson(),
    };
  }
}
