import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:app_pelis/src/providers/title_movie_provider.dart';
import 'package:app_pelis/src/widgets/title_movie_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  final double height;

  CardSwiper({required this.peliculas, required this.height});

  @override
  Widget build(BuildContext context) {
    final movieTitleProvider = Provider.of<MovieTitleProvider>(context,listen: false);
    Future.microtask(() => movieTitleProvider.pelicula = peliculas[0]);

    final heightPercent = this.height * .8;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Swiper(
          itemWidth: heightPercent * (10/16),
          itemHeight: heightPercent,
          itemCount: peliculas.length,
          layout: SwiperLayout.STACK,
          onIndexChanged: (index) => movieTitleProvider.pelicula = peliculas[index],
          itemBuilder: (context, i) {
            Pelicula pelicula = peliculas[i];
            pelicula.uniqueId = '${peliculas[i].id}-cards';
            return _Card(pelicula);
          },
        ),

      ],
    );
  }
}


class _Card extends StatelessWidget {
  Pelicula pelicula;

  _Card(this.pelicula);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10/16,
      child: Hero(
        tag: pelicula.uniqueId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detalle', arguments: pelicula),
            child: CachedNetworkImage(
              imageUrl: pelicula.getPosterImg(),
              placeholder: (_,dataStr)=> Image.asset('assets/img/no-image.jpg', fit: BoxFit.cover,),
              errorWidget: (_,__,___)=> Container(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
