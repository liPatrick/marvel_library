import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:marvel_library/app.dart';
import 'package:marvel_library/simple_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'character/character.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  /*HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );*/

  runApp(BlocProvider(
    create: (context) =>
        CharacterBloc(httpClient: http.Client())..add(CharacterListFetched()),
    child: App(),
  ));
}
