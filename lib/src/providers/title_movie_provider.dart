import 'package:flutter/material.dart';
import 'package:app_pelis/src/models/pelicula_model.dart';

class MovieTitleProvider extends ChangeNotifier{

  Pelicula _pelicula = Pelicula.empty();
  Pelicula get pelicula => _pelicula;

  set pelicula(Pelicula pelicula){
    this._pelicula = pelicula;
    notifyListeners();
  }

}