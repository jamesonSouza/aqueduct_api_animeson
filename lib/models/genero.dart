import 'package:serve_exemplo/models/genero_animes.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class Genero extends ManagedObject<_Genero> implements _Genero{}

class _Genero{
  
  @primaryKey
  int id;

  String nome;
  
 ManagedSet<GeneroAnime> generoAnime;


}