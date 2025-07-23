class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final List<String> genres;
  final int year;
  final double rating;
  final String description;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.genres,
    required this.year,
    required this.rating,
    required this.description,
  });

  static List<Movie> mockMovies = [
    Movie(
      id: '1',
      title: 'The Great Adventure',
      posterUrl: 'https://picsum.photos/12001',
      backdropUrl: 'https://picsum.photos/400?random=10',
      genres: ['Action', 'Adventure'],
      year: 2023,
      rating: 8.2,
      description: 'An epic journey of heroes and legends.',
    ),
    Movie(
      id: '2',
      title: 'Romance in Paris',
      posterUrl: 'https://picsum.photos/12002',
      backdropUrl: 'https://picsum.photos/400?random=20',
      genres: ['Romance', 'Drama'],
      year: 2022,
      rating: 7.5,
      description: 'A love story set in the heart of Paris.',
    ),
    Movie(
      id: '3',
      title: 'Sci-Fi Odyssey',
      posterUrl: 'https://picsum.photos/12003',
      backdropUrl: 'https://picsum.photos/400?random=30',
      genres: ['Sci-Fi', 'Thriller'],
      year: 2024,
      rating: 8.7,
      description: 'A mind-bending journey through space and time.',
    ),
    Movie(
      id: '4',
      title: 'Mystery Manor',
      posterUrl: 'https://picsum.photos/12004',
      backdropUrl: 'https://picsum.photos/400?random=40',
      genres: ['Mystery', 'Thriller'],
      year: 2023,
      rating: 7.8,
      description: 'A mysterious mansion holds dark secrets.',
    ),
    Movie(
      id: '5',
      title: 'Comedy Central',
      posterUrl: 'https://picsum.photos/12005',
      backdropUrl: 'https://picsum.photos/400?random=50',
      genres: ['Comedy', 'Romance'],
      year: 2024,
      rating: 7.2,
      description: 'Laughs and love in the big city.',
    ),
  ];
}
