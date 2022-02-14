class Cast {
  List<Actor> actores = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach(
      (element) {
        actores.add(Actor.fromJsonMap(element));
      },
    );
  }
}

class Actor {
  late bool adult;
  late int gender;
  late int id;
  late String knownForDepartment;
  late String name;
  late String originalName;
  late double popularity;
  String? profilePath;
  late int castId;
  late String character;
  late String creditId;
  late int order;
  late String department;
  late String job;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    job = json['job'] ?? '';
    name = json['name'] ?? '';
    order = json['order'] ?? 0;
    adult = json['adult'] ?? false;
    gender = json['gender'] ?? 0;
    popularity = json['popularity'] ?? 0;
    profilePath = json['profile_path'] ?? null;
    castId = json['cast_id'] ?? 0;
    character = json['character'].toString().length == 0 ? '-': json['character'];
    creditId = json['credit_id'] ?? '';
    department = json['department'] ?? '';
    originalName = json['original_name'] ?? '';
    knownForDepartment = json['known_for_department'] ?? '';
  }

  String getFoto() {
    if (profilePath == null) {
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdy9MzI8YXc-v9nsSWVkgMaRTexZqdmtRsjg&usqp=CAU';
    } else {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
  }
}
