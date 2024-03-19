part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent  {
}


class LoadedMovieDetail extends MovieDetailEvent {
  final int movieId;
  LoadedMovieDetail({required this.movieId});
} 