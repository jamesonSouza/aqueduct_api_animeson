import 'package:serve_exemplo/models/genero.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class GeneroController extends ResourceController {
      GeneroController(this.context);
      ManagedContext context;


   @Operation.get()
  Future<Response> getAllGenero()async{
    try {      
      final generoQuery  =Query<Genero>(context);
      return Response.ok(await generoQuery.fetch());
    } catch (e) {
      throw Response.noContent();
    }

  }
 
  //-animes/generos
  @Operation.post()
  Future<Response> createGenero(
         @Bind.body() Genero genero
    )async{
    try {
      final generoQuery= Query<Genero>(context)
      ..values= genero;
      
      return Response.ok( await generoQuery.insert());
    } catch (e) {
      throw Response.badRequest(body: "$e");
    }
  }

   @Operation.get('id')
  Future<Response> getGeneroId(@Bind.path('id') int id) async {
    try {
      final generoQuery = Query<Genero>(context)
        ..where((a) => a.id).equalTo(id);
      final genero = await generoQuery.fetchOne();

      if (genero == null) {
        throw Exception();
      }
      return Response.ok(genero);
    } catch (e) {
      return Response.notFound();
    }
  }


  @Operation.put('id')
  Future<Response> updateAnime(@Bind.path('id') int id, @Bind.body() Genero genero)async{
    try {
      final generoQuery = Query<Genero>(context)
      ..values=genero
      ..where((a)=> a.id).equalTo(id);
      

      return Response.ok(await generoQuery.updateOne());

    } catch (e) {
      throw Response.notFound();
    }
  }

  @Operation.delete('id')
  Future<Response> deleteGenero(@Bind.path('id')int id)async{
    try {
      final generoQuery = Query<Genero>(context)
      ..where((a)=> a.id).equalTo(id);
      return Response.ok(await generoQuery.delete());
    } catch (e) {
      throw Response.badRequest();
    }
  }

}