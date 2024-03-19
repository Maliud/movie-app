import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/infrastructure/repositories/actor_repository_impl.dart';
import 'package:movie_app/presentation/blocs/actors_movie/actors_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/local_storage/local_storage_bloc.dart';
import 'package:movie_app/presentation/blocs/movie/movies_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_popular/movie_popular_bloc.dart';
import 'package:movie_app/presentation/blocs/next_movie/next_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/theme/theme_bloc.dart';

import 'config/router/app_router.dart';
import 'infrastructure/datasources/isar_datasource.dart';
import 'infrastructure/datasources/moviedb_datasource.dart';
import 'infrastructure/repositories/local_storage_repository_impl.dart';
import 'infrastructure/repositories/movie_repository_impl.dart';

Future<void> main() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
  }
  await dotenv.load(fileName: ".env");
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc(
            movieRepository: MovieRepositoryImpl(
              datasource: MoviedbDatasource(),
            ),
          ),
        ),
        BlocProvider<MoviePopularBloc>(
          create: (_) => MoviePopularBloc(
            movieRepository: MovieRepositoryImpl(
              datasource: MoviedbDatasource(),
            ),
          ),
        ),
        BlocProvider<NextMovieBloc>(
          create: (_) => NextMovieBloc(
            movieRepository: MovieRepositoryImpl(
              datasource: MoviedbDatasource(),
            ),
          ),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => MovieDetailBloc(
            movieRepository: MovieRepositoryImpl(
              datasource: MoviedbDatasource(),
            ),
          ),
        ),
        BlocProvider<LocalStorageBloc>(
          create: (context) => LocalStorageBloc(
            repository: LocalStorageRepositoryImpl(
              datasource:IsarDatasource()
            ),

            )
        ),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, DarkModeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          routerConfig: appRouter,
          theme: state.theme == AppTheme.light
              ? ThemeData.light(useMaterial3: true)
              : ThemeData.dark(
                  useMaterial3: true,
                ),
        );
      },
    );
  }
}
