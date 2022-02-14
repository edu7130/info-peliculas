class Peliculas {
  List<Pelicula> items = [];

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {

  String uniqueId = '';
  String uniqueTitle = '';

  late int voteCount;
  late int id;
  late bool video;
  late double voteAverage;
  late String title;
  late double popularity;
  late String? posterPath;
  late String originalLanguage;
  late String originalTitle;
  late List<int> genreIds;
  late String? backdropPath;
  late bool adult;
  late String overview;
  late String releaseDate;

  Pelicula({
    required this.voteCount,
    required this.id,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.popularity,
    this.posterPath = '',
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    this.backdropPath = '',
    required this.adult,
    required this.overview,
    required this.releaseDate,
  });

  Pelicula.empty(){
    this.voteCount = 0;
    this.id = 0;
    this.video = false;
    this.voteAverage = 0;
    this.title = '';
    this.popularity = 0;
    this.originalLanguage = '';
    this.originalTitle = '';
    this.genreIds = [];
    this.adult = false;
    this.overview = '';
    this.releaseDate = '';
  }

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'].toString().length == 0 ?'Sin descripción':json['overview'];
    releaseDate = json['release_date'];
  }

  String getPosterImg() {
    if (posterPath == null) {
      return 'https://www.haedosrl.com.ar/images/frontend/notfound.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }
  String getBackgroundImg() {
    if (backdropPath == null) {
      return 'https://www.haedosrl.com.ar/images/frontend/notfound.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
