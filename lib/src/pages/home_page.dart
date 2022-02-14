import 'package:flutter/material.dart';
import 'package:app_pelis/src/search/search_delegate.dart';

import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:app_pelis/src/providers/peliculas_service.dart';
import 'package:app_pelis/src/widgets/card_swiper_widget.dart';
import 'package:app_pelis/src/widgets/list_view_populares.dart';
import 'package:app_pelis/src/widgets/title_movie_swiper.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        title: Text('Películas en cine'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: LayoutBuilder(
            builder: (_, constraints) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SwipperMovies(
                  height: constraints.maxHeight,
                ),
                SizedBox(height: 8),
                TitleMovie(),
              ],
            ),
          )),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Populares', style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16), textAlign: TextAlign.start),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .25,
            child: ListViewPopulares(),
          )
        ],
      ),
    );
  }
}

class _SwipperMovies extends StatelessWidget {
  final double height;

  const _SwipperMovies({required this.height});

  @override
  Widget build(BuildContext context) {
    final peliculasService = PeliculasService();
    return FutureBuilder(
      future: peliculasService.getEnCines(),
      builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data!,
            height: height,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
