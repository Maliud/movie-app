part of 'actors_movie_bloc.dart';

sealed class ActorsMovieEvent {

}


class LoadedActorsMovie extends ActorsMovieEvent {
  final int movieId;
  LoadedActorsMovie({required this.movieId});
} 