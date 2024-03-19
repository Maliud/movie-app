part of 'local_storage_bloc.dart';

sealed class LocalStorageEvent extends Equatable {
  const LocalStorageEvent();

  @override
  List<Object> get props => [];
}





class CheckFavoriteEvent extends LocalStorageEvent {
  final int movieId;

  CheckFavoriteEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class ToggleFavoriteEvent extends LocalStorageEvent {
  final Movie movie;

  ToggleFavoriteEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

class LoadMoviesEvent extends LocalStorageEvent {
  final int limit;
  final int offset;

  LoadMoviesEvent({required this.limit, required this.offset});

  @override
  List<Object> get props => [limit, offset];
}