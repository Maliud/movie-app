import 'package:bloc/bloc.dart';
import 'package:movie_app/domain/entities/actor.dart';

import '../../../infrastructure/repositories/actor_repository_impl.dart';

part 'actors_movie_event.dart';
part 'actors_movie_state.dart';

class ActorsMovieBloc extends Bloc<ActorsMovieEvent, ActorsMovieState> {
  final ActorRepositoryImpl actorRepositoryImpl;


  ActorsMovieBloc({required this.actorRepositoryImpl})
      : super(ActorsMovieInitial()) {


        
    on<LoadedActorsMovie>((event, emit) async{
      try {

        emit(ActorsMovieInitial());
        final actors = await actorRepositoryImpl.getActorsByMovie(event.movieId);
        
          emit(ActorsMovieLoaded(actors));
      } catch (e, s) {
        emit(MovieActorsError(e.toString() + s.toString()));
      }
    });
  }
}
 