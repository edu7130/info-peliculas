import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:app_pelis/src/providers/peliculas_service.dart';
import 'package:app_pelis/src/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  final peliculaProvider = PeliculasService();


  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando la persona escribe

    return FutureBuilder(
      future: peliculaProvider.buscarPelicula(query),
      builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!
                .map(
                  (e) => ListTile(
                    leading: FadeInImage(
                      image: NetworkImage(e.getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    title: Text(e.title,style: TextStyle(color: Colors.black87.withOpacity(.8),fontWeight: FontWeight.w600),),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.deepPurple,
                        ),
                        Text(e.voteAverage.toString(),style: TextStyle(color: Colors.black54),)
                      ],
                    ),
                    onTap: () {
                      close(context, null);
                      e.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle', arguments: e);
                    },
                  ),
                )
                .toList(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
