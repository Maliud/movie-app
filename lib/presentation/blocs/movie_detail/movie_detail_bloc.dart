// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../infrastructure/repositories/movie_repository_impl.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepositoryImpl movieRepository;

  MovieDetailBloc({required this.movieRepository})
      : super(MovieDetailInitial()) {
    on<LoadedMovieDetail>((event, emit) async {
      try {

        if (state is MovieDetailLoaded) {
          final movie = (state as MovieDetailLoaded).movie;
          if (movie.id == event.movieId) {
            return;
          }
        }


        final movie = await movieRepository.getMovieById(event.movieId);

        if (movie != null) {
          emit(MovieDetailLoaded(movie));
        } else {
          emit(MovieDetailError("Error"));
        }
      } catch (e, s) {
        emit(MovieDetailError(e.toString() + s.toString()));
      }
    });
  }
}
