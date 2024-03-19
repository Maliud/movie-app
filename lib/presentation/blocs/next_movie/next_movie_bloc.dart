import 'package:bloc/bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../infrastructure/repositories/movie_repository_impl.dart';

part 'next_movie_event.dart';
part 'next_movie_state.dart';

class NextMovieBloc extends Bloc<NextMovieEvent, NextMovieState> {
  final MovieRepositoryImpl movieRepository;

  NextMovieBloc({required this.movieRepository}) : super(NextMovieInitial()) {


    on<LoadedMovieNext>((event, emit) async {
      try {
        final movies = await movieRepository.getUpcoming(page: event.page);

          final currentState = state;
          if (currentState is MoviesLoadedNext) {
            final List<Movie> oldMovies = currentState.movies;
            final List<Movie> allMovies = List.from(oldMovies)..addAll(movies);
            emit(MoviesLoadedNext(allMovies, event.page));
          } else {
            emit(MoviesLoadedNext(movies, event.page));
          }
      } catch (e, s) {
        emit(MoviesErrorNext(e.toString() + s.toString()));
      }
    });
  }
}
 