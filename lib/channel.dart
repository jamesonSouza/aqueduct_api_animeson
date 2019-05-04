import 'package:serve_exemplo/controllers/alfabeto_controller.dart';
import 'package:serve_exemplo/controllers/anime_controller.dart';
import 'package:serve_exemplo/controllers/episodioController.dart';
import 'package:serve_exemplo/controllers/genero_anime_controller.dart';
import 'package:serve_exemplo/controllers/genero_controller.dart';
import 'package:serve_exemplo/controllers/join_anime_temp_ep.dart';
import 'package:serve_exemplo/controllers/temporada_controller.dart';
import 'package:serve_exemplo/controllers/temporada_join_controller.dart';

import 'serve_exemplo.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class ServeExemploChannel extends ApplicationChannel {
  ManagedContext context;
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistenceStore=PostgreSQLPersistentStore('animes_user', 'password', 'localhost',5432, 'animes_on');

    context= ManagedContext(dataModel, persistenceStore);
  }
//aqueduct db upgrade --connect postgres://teste_user:password@localhost:5432/teste_base
  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/

  //obtem anime por Id
  router
    .route("/animes/[:id]")
    .link(()=> AnimeController(context));
//////////////obtem anime/////////////////////////

  /*para cadastrar novo anime a temporada 
  estrutura json 
    {
      "descricao": ""
    }
  */
  router
    .route("/animes/:animeId/temporadas")
    .link(()=> TemporadaController(context));
//////////////cadastrar novo anime a temporada/////////////////////////
router
    .route("/animes/temporadas/[:id]")
    .link(()=> TemporadaController(context));

  /*para cadastrar novo episodio a temporada 
  estrutura json post
  {
     "urlImage": ""
     "urlVideo": ""
     "descricao": ""
     "numEpsodio": 0
  }
  */
  router
    .route("/animes/:tempId/episodios/[:id]")
    .link(()=> EpisodioController(context));  

//exibe epsodio e temporada
    router
    .route("/animes/episodios/[:id]")
    .link(()=> EpisodioController(context));  


//recupera os animes cadastrados 
  router
    .route("/animes/alfabetos/[:id]")
    .link(()=>AlfabetoController(context));

  //POST para adicionar anime ao alfabeto
  /*{
      "letra":"" // recebe a letra do alfabeto que o anime passa
  }*/
  router
    .route("/animes/:animeId/alfabetos/[:id]")
    .link(()=>AlfabetoController(context));


  


  // ver animes com toda estruturas com joins pode por id para filtrar o anime unico
  router
    .route("/animes/completos/[:id]")
    .link(()=>JoinAnimeTempEpiController(context));

  /* recupera animes por letra inicial  */
   router
    .route("/animes/alfabeto/[:letra]")
    .link(()=>JoinAnimeTempEpiController(context));
  
  // ver ageneros cadastrados por id ou sem parametros

router
    .route("/animes/search/[:search]")
    .link(()=>JoinAnimeTempEpiController(context));
  

  router
    .route("/animes/generos/[:id]")
    .link(()=>GeneroController(context));
  /*rota para cadastro de anime aos generos  usa o Id do anime + o Id do genero /generos 
    retorna status 200 
  */
  router
    .route("/animes/:animeId/:generoId/generos")
    .link(()=>GeneroAnimeAnimeController(context));

  //ver  generos dos animes por id anime e id genero 
 /* router
    .route("/animes/generos/animes/find")
    .link(()=>GeneroAnimeAnimeController(context));*/

  //recupera generos dos animes 
  router
    .route("/animes/generosanime/[:nome]")
    .link(()=> JoinAnimeTempEpiController(context));

router
    .route("/animes/temporada/[:id]")
    .link(()=> TemporadaJoinController(context));

router
    .route("/animes/:temp/temporada")
    .link(()=> TemporadaJoinController(context));


    return router;
  }
}