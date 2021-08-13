import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_library/character_api.dart';
import 'package:marvel_library/character_details/character_details.dart';
import 'package:http/http.dart' as http;

class CharacterDetailsPage extends StatelessWidget {
  Page page() => MaterialPage<void>(
          child: CharacterDetailsPage(
        id: id,
      ));

  final String id;

  const CharacterDetailsPage({
    Key? key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    CharacterAPI characterAPI = CharacterAPI(httpClient: http.Client());

    return BlocProvider(
      create: (_) => CharacterDetailsBloc(id: id, characterAPI: characterAPI)
        ..add(CharacterDetailsFetched()),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.pop(context)),
          title: const Text('Details'),
        ),
        body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
            builder: (context, state) {
          switch (state.status) {
            case CharacterDetailsStatus.failure:
              return const Center(child: Text('failed to fetch Character'));
            case CharacterDetailsStatus.success:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(state.character!.name,
                        style: theme.textTheme.headline6),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        state.character!.description != null
                            ? state.character!.description!
                            : 'N/A',
                        style: theme.textTheme.subtitle1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Comics: '),
                  ),
                  Expanded(
                    child: state.character!.comics != null
                        ? ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return ComicListItem(
                                post: state.character!.comics![index],
                              );
                            },
                            itemCount: state.character!.comics!.length,
                          )
                        : Text('No comics'),
                  ),
                ],
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
