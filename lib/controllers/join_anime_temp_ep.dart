import 'package:serve_exemplo/models/alfabeto.dart';
import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/models/genero_animes.dart';
import 'package:serve_exemplo/models/temporada.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class JoinAnimeTempEpiController extends ResourceController{
  JoinAnimeTempEpiController (this.context);
  ManagedContext context;

  //animes
  @Operation.get()
  Future<Response> getAllAnime()async{
    try {      
      final animeQuery  =Query<Anime>(context)
      ..join(set:(a)=> a.temporada)
    .join(set:(temporada)=> temporada.episodios);
    

      return Response.ok(await animeQuery.fetch());
    } catch (e) {
      throw Response.badRequest(body: e);
    }
  }
  //animes/completos/{id}
  @Operation.get('id')
  Future<Response> getAnimeId(@Bind.path('id') int id)async{
    try {      
      final animeQuery  =Query<Anime>(context)
      ..join(set:(a)=> a.temporada)
    .join(set:(temporada)=> temporada.episodios)
    ..join(set:(a)=> a.alfabeto)
    ..where((a)=> a.id).equalTo(id);

    if(await animeQuery.fetch()==null){
      return Response.notFound(body: "Vazio");
    }
      return Response.ok(await animeQuery.fetch());
    } catch (e) {
      throw Response.badRequest(body: e);
    }
  }
 @Operation.get('search')
  Future<Response> getAnimeNome(@Bind.path('search') String search)async{
    try {      
      final animeQuery  =Query<Anime>(context)
       ..where((b)=> b.nome).contains(search, caseSensitive: false)
       
      ..join(set:(a)=> a.temporada)
    .join(set:(temporada)=> temporada.episodios);
    //..join(set:(a)=> a.nome);
   
    //..where((a)=> a.nomeAlternativo).contains(search);

    if(await animeQuery.fetch()==null){
      return Response.notFound(body: "Vazio");
    }
      return Response.ok(await animeQuery.fetch());
    } catch (e) {
      throw Response.badRequest(body: e);
    }
  }

/////////////////////////////////////////////////////////////////////
  //busca por letra do alfabeto
  //animes/alfabeto/{letra}
  @Operation.get('letra')
  Future<Response> getAlfabetAnime(@Bind.path('letra') String letra)async{
try { 
    final alfabetoQuery = Query<Alfabeto> (context)
    ..join(object: (a) => a.anime)
    ..where((ab)=> ab.letra).equalTo(letra);
    final result = await alfabetoQuery.fetch();
    
    if(result.isEmpty){
      return Response.notFound(body: "Não econtrado");
    }
    return Response.ok(result); 

} catch (e) {
  throw Response.notFound();
}

  }
//////////////////////////////////////////////////////////////////////////////////
  //obter animes por generos 
  //animes/generos/[:id]||[:nome]

  @Operation.get('nome')
  Future<Response> getAnimeByGenero(
    @Bind.path('nome') String nome,
   // @Bind.path('id') int id,
    
  )async{
    try {
      
      final result = Query<GeneroAnime>(context)
    ..join(object: (a)=> a.anime)
    ..join(object: (b)=> b.genero)
    ..where((ab)=> ab.genero.nome ).contains(nome);
    //..where((ab)=> ab.genero.id).equalTo(id);

    final resultCondition = await result.fetch();

    if(resultCondition==null){
      return Response.notFound(body: "Não econtrado");
    }
    return Response.ok(resultCondition);
    } catch (e) {
      throw Response.badRequest();
    }


  }


}