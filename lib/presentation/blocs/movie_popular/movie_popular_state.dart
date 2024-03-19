part of 'movie_popular_bloc.dart';

sealed class MoviePopularState{
  const MoviePopularState();
  
}

 class MoviePopularInitial extends MoviePopularState {}

class MoviesPopularLoaded extends MoviePopularState {
  final int page;
  final List<Movie> movies;
  MoviesPopularLoaded(this.movies, this.page) : super();
  
}

class MoviesError extends MoviePopularState {
  final String message;
  MoviesError(this.message);
} 

