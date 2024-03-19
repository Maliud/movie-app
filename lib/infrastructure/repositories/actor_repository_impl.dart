
import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../../domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;
  
  ActorRepositoryImpl({ required this.datasource});


  @override
  Future<List<Actor>> getActorsByMovie(int movieId){
    return datasource.getActorsByMovie(movieId);
  }


}