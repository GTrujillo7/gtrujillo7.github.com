import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculasapp/src/models/pelicula_model.dart';
import 'package:peliculasapp/src/models/actores_model.dart';

class PeliculasProvider {
  String _apikey = "b8581c4e8c51346790842e2486ae99ec";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  // Aqui se optimizo el codigo para no repetir esto en cada peticion
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData["results"]);

    return peliculas.items;
  }

  // Hecho con la primera forma sin utilizar procesar respuesta
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {"api_key": _apikey, "language": _language});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData["results"]);

    return peliculas.items;
  }

  // Metodo 2: Utilizando la optimizacion de codigo con _procesarRespuesta
  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apikey,
      "language": _language,
      "page": _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, "3/movie/$peliId/credits", {
      "api_key": _apikey,
      "language": _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData["cast"]);

    return cast.actores;
  }
}
