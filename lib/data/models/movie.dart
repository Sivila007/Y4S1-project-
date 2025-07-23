// Movie model for the app
class Movie {
  final String id;
  final String title;
  final int year;
  final String genre;
  final String posterUrl;
  final String backdropUrl;
  final double rating;
  final String description;
  final List<String> cast;
  final List<String> relatedMovieIds;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
    required this.description,
    required this.cast,
    required this.relatedMovieIds,
  });
}
