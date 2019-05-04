import 'package:serve_exemplo/models/alfabeto.dart';
import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/models/episodio.dart';
import 'package:serve_exemplo/models/genero_animes.dart';
import 'package:serve_exemplo/models/temporada.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class TemporadaJoinController extends ResourceController{
  TemporadaJoinController (this.context);
  ManagedContext context;

 
  @Operation.get( 'id')
  Future<Response> getAnimeEpisode(
    @Bind.path('id') int id
    
  )async{
    try {
        final animeQuery =Query <Temporada>(context)
        ..join(set: (temporada)=> temporada.episodios)
          ..join(object: (temporada)=> temporada.animes)
             ..where((temporada)=> temporada.id).equalTo(id);

        return Response.ok(animeQuery.fetch());
    } catch (e) {
        throw Exception(e);
    }
  }

  @Operation.get('temp')
  Future<Response> getEpisodeOfAnime(
    @Bind.path('temp') int id
  )async{
    try {
        final animeQuery =Query <Temporada>(context)
           .join(set: (a)=> a.episodios) 
           ..sortBy((a)=>a.id, QuerySortOrder.ascending)             
          ..where((episodios)=> episodios.temporada.animes.id).equalTo(id);

          

    if(await animeQuery.fetch()==null){
      return Response.notFound(body: "Vazio");
    }
      return Response.ok(await animeQuery.fetch());      
       
    } catch (e) {
        throw Exception(e);
    }
  }


}