import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_library/character/character.dart';

class CharacterListPage extends StatelessWidget {
  Page page() => MaterialPage<void>(
          child: CharacterListPage(
        characters: characters,
      ));

  final List<Character> characters;
  const CharacterListPage({
    Key? key,
    required this.characters,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters')),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          switch (state.status) {
            case CharacterStatus.failure:
              return const Center(child: Text('failed to fetch characters'));
            case CharacterStatus.success:
              if (state.characters.isEmpty) {
                return const Center(child: Text('no characters'));
              }
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return CharacterListItem(post: state.characters[index]);
                  },
                  itemCount: state.characters.length);
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
