import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/models/genero.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class GeneroAnime extends ManagedObject<_GeneroAnime> implements _GeneroAnime{}

class _GeneroAnime{
  @primaryKey
  int id;

  //String content;

  @Relate(#generoAnime)
  Anime anime;
  
  
  @Relate(#generoAnime)
  Genero genero;
  

  

}