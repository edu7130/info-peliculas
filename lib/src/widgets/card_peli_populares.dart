import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardPeliPopulares extends StatelessWidget {
  final Pelicula pelicula;

  CardPeliPopulares(this.pelicula);

  @override
  Widget build(BuildContext context) {
    pelicula.uniqueId = '${pelicula.id}-detalle';
    return Container(
      width: MediaQuery.of(context).size.width * .2,
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'detalle', arguments: pelicula),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: pelicula.uniqueId,
              child: AspectRatio(
                aspectRatio: 10 / 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: pelicula.getPosterImg(),
                    placeholder: (_, dataStr) => Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),
                    errorWidget: (_, __, ___) => Container(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
