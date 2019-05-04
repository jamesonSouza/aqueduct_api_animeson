import 'package:serve_exemplo/models/alfabeto.dart';
import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/models/temporada.dart';
import 'package:serve_exemplo/serve_exemplo.dart';


class AlfabetoController extends ResourceController{
  AlfabetoController (this.context);
  ManagedContext context;

  //animes/alfabeto
  @Operation.get()
  Future<Response> getAllAlfabet()async{
    try {      
      final alfabetQuery  =Query<Alfabeto>(context);
      return Response.ok(await alfabetQuery.fetch());
    } catch (e) {
      throw Response.noContent();
    }

  }
 
 
  //-animes/{animeId}/alfabeto
  @Operation.post('animeId')
  Future<Response> createAlfabetoByAlfabet(
    @Bind.path('animeId')int animeId, 
    @Bind.body() Alfabeto alfabeto
    )async{
    try {
      final alfabetQuery= Query<Alfabeto>(context)
      ..values= alfabeto
      ..values.anime.id= animeId;
      return Response.ok( "${await alfabetQuery.insert()} Alfabeto inserida");
    } catch (e) {
      throw Response.badRequest(body: "$e");
    }
  }

   @Operation.get('id')
  Future<Response> getAlfabetoId(@Bind.path('id') int id) async {
    try {
      final alfabetQuery = Query<Alfabeto>(context)
        ..where((a) => a.id).equalTo(id);
      final temporada = await alfabetQuery.fetchOne();

      if (temporada == null) {
        throw Exception();
      }
      return Response.ok(temporada);
    } catch (e) {
      return Response.notFound();
    }
  }
  @Operation.put('id')
  Future<Response> updateAnime(@Bind.path('id') int id, @Bind.body() Alfabeto alfabeto)async{
    try {
      final alfabetQuery = Query<Alfabeto>(context)
      ..values=alfabeto
      ..where((a)=> a.id).equalTo(id);
      

      return Response.ok(await alfabetQuery.updateOne());

    } catch (e) {
      throw Response.notFound();
    }
  }

  @Operation.delete('id')
  Future<Response> deleteAlfabet(@Bind.path('id')int id)async{
    try {
      final alfabetQuery = Query<Alfabeto>(context)
      ..where((a)=> a.id).equalTo(id);
      return Response.ok(await alfabetQuery.delete());
    } catch (e) {
      throw Response.badRequest();
    }
  }




}