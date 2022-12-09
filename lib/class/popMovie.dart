class PopMovie {
  int id;
  String title;
  String homepage;
  String overview;
  String release_date;
  int runtime;
  List? genres;
  List? persons;

  PopMovie(
      {required this.id,
      required this.title,
      required this.homepage,
      required this.overview,
      required this.release_date,
      required this.runtime,
      this.genres,
      this.persons});
  factory PopMovie.fromJson(Map<String, dynamic> json) {
    return PopMovie(
        id: json['movie_id'] as int,
        title: json['title'] as String,
        homepage: json['homepage'] as String,
        overview: json['overview'] as String,
        release_date: json['release_date'] as String,
        runtime: json['runtime'] as int,
        genres: json['genres'],
        persons: json['person']);
  }
}
