import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/models/episodio.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class Temporada extends ManagedObject<_Temporada> implements _Temporada{}

class _Temporada{

  @primaryKey
  int id;  
 
  String descricao;

  @Relate(#temporada)
  Anime animes;


  ManagedSet<Episodio> episodios;

  
  
    
}