part of 'next_movie_bloc.dart';

sealed class NextMovieEvent  {
}


class LoadedMovieNext extends NextMovieEvent {
  final int page;
  LoadedMovieNext({required this.page});
}

 