import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/serve_exemplo.dart';


class AnimeController extends ResourceController{
  AnimeController (this.context);
  ManagedContext context;

  //animes
  @Operation.get()
  Future<Response> getAllAnime()async{
    try {      
      final animeQuery  =Query<Anime>(context);
      return Response.ok(await animeQuery.fetch());
    } catch (e) {
      throw Response.noContent();
    }

  }

  //-animes/[:id]
  @Operation.get('id')
  Future<Response> getAnimeId(@Bind.path('id') int id)async{
    try {
      final animeQuery = Query<Anime>(context)
      ..where((a)=> a.id).equalTo(id);
      
      return Response.ok(await animeQuery.fetchOne());
    } catch (e) {
      return Response.notFound(body: "dont found $e");
    }
  }
  

  //METODOS DE CRIACAO E EDICAO
  @Operation.post()
  Future<Response> createNewAnime(@Bind.body() Anime anime)async{
    try {
      final animeQuery= Query<Anime>(context)
      ..values= anime;
      return Response.ok( await animeQuery.insert());
    } catch (e) {
      throw Response.badRequest(body: "$e");
    }
  }

  @Operation.put('id')
  Future<Response> updateAnime(@Bind.path('id') int id, @Bind.body() Anime anime)async{
    try {
      final animeQuery = Query<Anime>(context)
      ..values=anime
      ..where((a)=> a.id).equalTo(id);

      return Response.ok(await animeQuery.updateOne());

    } catch (e) {
      throw Response.notFound();
    }
  }

  @Operation.delete('id')
  Future<Response> deleteAnime(@Bind.path('id')int id)async{
    try {
      final animeQuery = Query<Anime>(context)
      ..where((a)=> a.id).equalTo(id);
      return Response.ok(await animeQuery.delete());
    } catch (e) {
      throw Response.badRequest();
    }
  }




}