part of 'movies_bloc.dart';

sealed class MoviesState {
  const MoviesState();

}


class MoviesInitial extends MoviesState {}


class MoviesLoaded extends MoviesState {
  final int page;
  final List<Movie> movies;
  MoviesLoaded(this.movies, this.page) : super();
  
}


class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
} 


 