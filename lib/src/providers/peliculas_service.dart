import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_pelis/src/models/actores_model.dart';
import 'package:app_pelis/src/models/pelicula_model.dart';

class PeliculasService {
  String _apiKey    = '8bcb99cc7b3ee0b429a6bc0d2b414248';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-MX';

  bool _cargando = false;
  int _popularesPage = 0;

  List<Pelicula> _populares = [];


  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  get popularesSink   => _popularesStreamController.sink.add;
  get popularesStream => _popularesStreamController.stream;



  void dispose(){
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = jsonDecode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'language': _language,
      'api_key': _apiKey
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'language': _language,
      'api_key' : _apiKey,
      'query'   : query
    });
    print(url);
    return await _procesarRespuesta(url);
  }

  
  Future<List<Pelicula>> getPopulares() async{
    if(_cargando) return [];
    _cargando = true;
    print('Obteniendo la pagina: $_popularesPage');
    _popularesPage ++;

    final url = Uri.https(_url, '3/movie/popular',{
      'language': _language,
      'api_key' : _apiKey,
      'page'    : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'language': _language,
      'api_key' : _apiKey,
    });

    final resp = await http.get(url);
    final decodeData = jsonDecode(resp.body);
    final cast = Cast.fromJsonList(decodeData['cast']);
    return cast.actores;
  }


}
