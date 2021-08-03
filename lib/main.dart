import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:marvel_library/app.dart';
import 'package:marvel_library/simple_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(App());
}
