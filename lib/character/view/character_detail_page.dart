import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_library/character/character.dart';

class CharacterDetailsPage extends StatelessWidget {
  Page page() => MaterialPage<void>(
          child: CharacterDetailsPage(
        character: character,
      ));

  final Character character;

  const CharacterDetailsPage({
    Key? key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () =>
              context.read<CharacterBloc>().add(CharacterDeselected()),
        ),
        title: const Text('Details'),
      ),
      body:
          BlocBuilder<CharacterBloc, CharacterState>(builder: (context, state) {
        switch (state.status) {
          case CharacterStatus.failure:
            return const Center(child: Text('failed to fetch Character'));
          case CharacterStatus.success:
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(character.name, style: theme.textTheme.headline6),
                  Text(
                      character.description != null
                          ? character.description!
                          : 'N/A',
                      style: theme.textTheme.subtitle1),
                ],
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
