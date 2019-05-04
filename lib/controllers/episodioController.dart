
import 'package:serve_exemplo/models/episodio.dart';

import 'package:serve_exemplo/serve_exemplo.dart';


class EpisodioController extends ResourceController{
  EpisodioController (this.context);
  ManagedContext context;

  //animes/animeId/id/episodios
  @Operation.get()
  Future<Response> getAllEpisodios()async{
    try {      
      final episodioQuery  =Query<Episodio>(context);
      return Response.ok(await episodioQuery.fetch());
    } catch (e) {
      throw Response.noContent();
    }

  }
 
  //-animes/{id}/{tempId}/e
  @Operation.post('tempId')
  Future<Response> createEpisodioBytemporada( 
    //@Bind.path('animeId') int animeId,    
    @Bind.path('tempId') int tempId, 
    @Bind.body() Episodio episodio
    )async{
    try {
      final episodioQuery= Query<Episodio>(context)
      ..values= episodio      
      ..values.temporada.id =tempId;
      
      return Response.ok( "${await episodioQuery.insert()} Episodio inserida");
    } catch (e) {
      throw Response.badRequest(body: "$e");
    }
  }

   @Operation.get('id')
  Future<Response> getEpisodioId(   
    @Bind.path('id') int id) async {
    try {
      final episodioQuery = Query<Episodio>(context)       
        ..where((e) => e.id).equalTo(id);
        
      final episodio = await episodioQuery.fetch();

      if (episodio == null) {
        throw Exception();
      }
      return Response.ok(episodio);
    } catch (e) {
      return Response.notFound();
    }
  }


  @Operation.put('id')
  Future<Response> updateEpisodio(@Bind.path('id') int id, @Bind.body() Episodio episodio)async{
    try {
      final episodioQuery = Query<Episodio>(context)
      ..values=episodio
      ..where((a)=> a.id).equalTo(id);
      

      return Response.ok(await episodioQuery.updateOne());

    } catch (e) {
      throw Response.notFound();
    }
  }

  @Operation.delete('id')
  Future<Response> deleteEpisodio(@Bind.path('id')int id)async{
    try {
      final episodioQuery = Query<Episodio>(context)
      ..where((e)=> e.id).equalTo(id);
      return Response.ok(await episodioQuery.delete());
    } catch (e) {
      throw Response.badRequest();
    }
  }




}