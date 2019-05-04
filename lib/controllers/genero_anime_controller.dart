import 'package:serve_exemplo/models/genero.dart';
import 'package:serve_exemplo/models/genero_animes.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class GeneroAnimeAnimeController extends ResourceController {
      GeneroAnimeAnimeController(this.context);
      ManagedContext context;


   @Operation.get()
  Future<Response> getAllGeneroAnime()async{
    try {      
      final generoQuery  =Query<GeneroAnime>(context);
      return Response.ok(await generoQuery.fetch());
    } catch (e) {
      throw Response.noContent();
    }

  }
 
  //-animes/{animeId}/{generoId}/generos
  @Operation.post('generoId','animeId')
  Future<Response> createGeneroAnime(
    @Bind.path('animeId') int animeId,
    @Bind.path('generoId') int genroId,
    //@Bind.body() GeneroAnime genero
    )async{
    try {
      final generoQuery= Query<GeneroAnime>(context)
     // ..values= genero
      ..values.anime.id= animeId
      ..values.genero.id= genroId;
      
      return Response.ok( await generoQuery.insert());
    } catch (e) {
      throw Response.badRequest(body: "$e");
    }
  }

}