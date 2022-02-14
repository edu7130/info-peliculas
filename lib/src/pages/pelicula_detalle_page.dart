import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:app_pelis/src/models/actores_model.dart';
import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:app_pelis/src/widgets/show_actor_dialog.dart';
import 'package:app_pelis/src/providers/peliculas_service.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pelicula pelicula = ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _AppBar(pelicula: pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              _PosterTitulo(pelicula: pelicula),
              _Descripcion(pelicula: pelicula),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Reparto',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              _Casting(pelicula: pelicula),
            ]),
          )
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final Pelicula pelicula;

  _AppBar({required this.pelicula});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      pinned: true,
      stretch: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        background: CachedNetworkImage(
          imageUrl: pelicula.getBackgroundImg(),
          placeholder: (_, dataStr) => Image.asset(
            'assets/img/loading.gif',
            fit: BoxFit.cover,
          ),
          errorWidget: (_, __, ___) => Container(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterTitulo extends StatelessWidget {
  final Pelicula pelicula;

  _PosterTitulo({required this.pelicula});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: pelicula.getPosterImg(),
                placeholder: (_, dataStr) => Image.asset('assets/img/no-image.jpg'),
                errorWidget: (_, __, ___) => Container(),
                height: 150,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.deepPurpleAccent,
                      //color: Colors.yellowAccent.shade400,
                    ),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Descripcion extends StatelessWidget {
  Pelicula pelicula;

  _Descripcion({required this.pelicula});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class _Casting extends StatelessWidget {
  Pelicula pelicula;

  _Casting({required this.pelicula});

  @override
  Widget build(BuildContext context) {
    final peliProvider = PeliculasService();

    return Container(
      height: 290,
      padding: EdgeInsets.only(top:10),
      child: FutureBuilder(
        future: peliProvider.getCast(pelicula.id.toString()),
        builder: (context, AsyncSnapshot<List<Actor>> snapshot) {
          if (snapshot.hasData) {
            return _ActoresListView(actores: snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
            );
          }
        },
      ),
    );
  }
}

class _ActoresListView extends StatelessWidget {
  List<Actor> actores;

  _ActoresListView({required this.actores});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: actores.length,
      itemBuilder: (context, i) {
        return _CardActor(actor: actores[i]);
      },
    );
  }
}

class _CardActor extends StatelessWidget {
  Actor actor;

  _CardActor({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
      width: MediaQuery.of(context).size.width * .28,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showActorDialog(context, actor),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38.withOpacity(.3),
                    //color: Colors.black.withOpacity(.2),
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: CachedNetworkImage(
                        imageUrl: actor.getFoto(),
                        placeholder: (_, dataStr) => Center(
                          child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                        ),
                        errorWidget: (_, __, ___) => Container(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      actor.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 2),
                    child: Text(
                      '${actor.character}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}

