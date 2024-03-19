part of 'movie_popular_bloc.dart';

sealed class MoviePopularEvent  {
}


class LoadedMoviesPopular extends MoviePopularEvent {
  final int page;
  LoadedMoviesPopular({required this.page});
}

