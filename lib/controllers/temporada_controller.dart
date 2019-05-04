import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/models/temporada.dart';
import 'package:serve_exemplo/serve_exemplo.dart';


class TemporadaController extends ResourceController{
  TemporadaController (this.context);
  ManagedContext context;

  //animes/temporada
  @Operation.get()
  Future<Response> getAllAnime()async{
    try {      
      final animeQuery  =Query<Temporada>(context);
      return Response.ok(await animeQuery.fetch());
    } catch (e) {
      throw Response.noContent();
    }

  }
 
  //-animes/{id}/temporada
  @Operation.post('animeId')
  Future<Response> createTemporadaByAnime(
    @Bind.path('animeId')int id, 
    @Bind.body() Temporada temporada
    )async{
    try {
      final temporadaQuery= Query<Temporada>(context)
      ..values= temporada
      ..values.animes.id=id;
      return Response.ok( await temporadaQuery.insert());
    } catch (e) {
      throw Exception("$e");
    }
  }

   @Operation.get('id')
  Future<Response> getTemporadaId(@Bind.path('id') int id) async {
    try {
      final temporadaQuery = Query<Temporada>(context)
        ..where((temporada) => temporada.id).equalTo(id);
      final temporada = await temporadaQuery.fetchOne();

      if (temporada == null) {
        throw Exception();
      }
      return Response.ok(temporada);
    } catch (e) {
      return Response.notFound();
    }
  }


  @Operation.put('id')
  Future<Response> updateTemporada(@Bind.path('id') int id, @Bind.body() Temporada temporada)async{
    try {
      final animeQuery = Query<Temporada>(context)
      ..values=temporada
      ..where((a)=> a.id).equalTo(id);
      

      return Response.ok(await animeQuery.updateOne());

    } catch (e) {
      throw Response.notFound();
    }
  }

  @Operation.delete('id')
  Future<Response> deleteAnime(@Bind.path('id')int id)async{
    try {
      final animeQuery = Query<Temporada>(context)
      ..where((a)=> a.id).equalTo(id);
      return Response.ok(await animeQuery.delete());
    } catch (e) {
      throw Response.badRequest();
    }
  }




}