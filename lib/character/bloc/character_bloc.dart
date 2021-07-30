import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:marvel_library/character/character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterState());

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
