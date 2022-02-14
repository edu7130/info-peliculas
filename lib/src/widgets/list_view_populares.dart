import 'package:app_pelis/src/providers/peliculas_service.dart';
import 'package:flutter/material.dart';

import 'package:app_pelis/src/models/pelicula_model.dart';

import 'card_peli_populares.dart';

class ListViewPopulares extends StatelessWidget {

  final peliculasProvider = PeliculasService();

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    _controller.addListener(() {
      if(_controller.position.pixels >= (_controller.position.maxScrollExtent-0)){
        peliculasProvider.getPopulares();
      }

    });

    return StreamBuilder(
      stream: peliculasProvider.popularesStream,
      builder: (_, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));

        return ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i) {
            final Pelicula pelicula = snapshot.data![i];
            return CardPeliPopulares(pelicula);
          },
        );
        return Container();
      },
    );
  }
}