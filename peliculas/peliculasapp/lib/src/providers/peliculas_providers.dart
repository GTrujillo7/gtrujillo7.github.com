import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:peliculasapp/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = "b8581c4e8c51346790842e2486ae99ec";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {"api_key": _apikey, "language": _language});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData["results"]);

    return peliculas.items;
  }
}
