import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_library/character/character.dart';
import 'package:marvel_library/character/view/character_list_page.dart';
import 'view.dart';
import 'package:flow_builder/flow_builder.dart';

List<Page> onGeneratePages(CharacterState state, List<Page> pages) {
  final selectedCharacter = state.selectedCharacter;
  return [
    CharacterListPage(characters: state.characters).page(),
    if (selectedCharacter != null)
      CharacterDetailsPage(character: selectedCharacter).page()
  ];
}

class CharacterPage extends StatefulWidget {
  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = context.read<CharacterBloc>();
    _characterBloc.add(CharacterListFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlowBuilder(
        state: context.watch<CharacterBloc>().state,
        onGeneratePages: onGeneratePages,
      ),
    );
  }
}
