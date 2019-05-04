import 'package:serve_exemplo/models/temporada.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class Episodio extends ManagedObject<_Episodio> implements _Episodio{}

class _Episodio{
  @primaryKey
  int id;

  String urlImage;

  String urlVideo;

  String descricao;

  int numEpsodio;

 
   @Relate(#episodios)
  Temporada temporada;
  

}