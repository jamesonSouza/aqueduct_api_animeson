import 'package:serve_exemplo/models/alfabeto.dart';
import 'package:serve_exemplo/models/genero_animes.dart';
import 'package:serve_exemplo/models/temporada.dart';
import 'package:serve_exemplo/serve_exemplo.dart';

class Anime extends ManagedObject<_Anime> implements _Anime{}

class _Anime{
  @primaryKey
  int id;

  String nome;

  String nomeAlternativo;

  String sinopse;

  String urlPoster;

  String autor;

  String estudio;

  String status;

  int ano;

  int numEpisodios;
  
  int temporadas;

   int likes;

  ManagedSet<Alfabeto> alfabeto;

  ManagedSet<Temporada> temporada;
  
  ManagedSet<GeneroAnime> generoAnime;


}