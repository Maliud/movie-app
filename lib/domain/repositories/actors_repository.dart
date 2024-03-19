

import '../entities/actor.dart';

abstract class ActorsRepository {

  Future<List<Actor>> getActorsByMovie( int movieId );

}