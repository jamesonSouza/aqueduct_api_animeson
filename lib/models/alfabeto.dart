import 'package:serve_exemplo/models/anime.dart';
import 'package:serve_exemplo/models/episodio.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class Alfabeto extends ManagedObject<_Alfabeto> implements _Alfabeto{}

class _Alfabeto{

  @primaryKey
  int id;  

  String letra;
  
   @Relate(#alfabeto)
  Anime anime;

  
  
    
}