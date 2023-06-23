import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:fav_youtube/screens/api.dart';

import 'bloc/favorite_bloc.dart';
import 'bloc/videos_bloc.dart';

void main() {
  API api = API();
  api.search('gato');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((_) => VideosBloc()),
        Bloc((_) => FavoriteBloc()),
      ],
      dependencies: const [],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Favoritos YT',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home()),
    );
  }
}

