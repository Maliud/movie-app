part of 'movie_detail_bloc.dart';

sealed class MovieDetailState  {
  const MovieDetailState();
  
}

final class MovieDetailInitial extends MovieDetailState {}



class MovieDetailLoaded extends MovieDetailState {
  final Movie movie;
  MovieDetailLoaded(this.movie) : super();
  
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);
} 


