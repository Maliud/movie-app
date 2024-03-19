part of 'movies_bloc.dart';

sealed class MoviesEvent {}



class LoadedMovie extends MoviesEvent {
  final int page;
  LoadedMovie({required this.page});
}

 