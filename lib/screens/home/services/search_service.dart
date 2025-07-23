import '../../../data/models/movie.dart';
import '../../../data/datasources/mock_movies.dart';

class SearchService {
  static List<Movie> searchMovies(String query) {
    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    return mockMovies.where((movie) {
      return movie.title.toLowerCase().contains(lowerQuery) ||
          movie.genre.toLowerCase().contains(lowerQuery) ||
          movie.cast.any((actor) => actor.toLowerCase().contains(lowerQuery)) ||
          movie.year.toString().contains(query);
    }).toList();
  }

  static List<String> getSearchSuggestions() {
    return [
      'Action movies',
      'Sci-Fi films',
      'Recent releases',
      'Top rated',
      'Adventure',
      'Biography',
    ];
  }

  static List<String> getPopularSearches() {
    return [
      'Dune',
      'Avatar',
      'Marvel',
      'Action',
      '2024',
      'Sci-Fi',
    ];
  }
}
