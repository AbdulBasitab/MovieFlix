class TrendingMovieDetail {
  final String? movieDetailTitle;
  var movieImage;
  final int? movieDetailId;
  final String? description;
  final String? backdrop;
  final double? rating;
  final String? releaseDate;
  final int? runTime;
  final String? imdbId;

  TrendingMovieDetail({
    this.movieDetailTitle,
    this.movieImage,
    this.movieDetailId,
    this.description,
    this.backdrop,
    this.rating,
    this.releaseDate,
    this.runTime,
    this.imdbId,
  });

  factory TrendingMovieDetail.fromJson(Map<String, dynamic> json) {
    return TrendingMovieDetail(
      movieDetailId: json["id"],
      movieDetailTitle: json["title"],
      movieImage: json["poster_path"],
      backdrop: json["backdrop_path"],
      description: json["overview"],
      rating: json["vote_average"],
      releaseDate: json["release_date"],
      runTime: json["runtime"],
      imdbId: json["imdb_id"],
    );
  }
}
