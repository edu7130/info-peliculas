import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:app_pelis/src/providers/title_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class TitleMovie extends StatelessWidget {

  TitleMovie();

  @override
  Widget build(BuildContext context) {
    final movieTitleProvider = Provider.of<MovieTitleProvider>(context);
    return Text(
      movieTitleProvider.pelicula.title,
      style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 22),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}

