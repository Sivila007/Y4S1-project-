import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/movie.dart';
import 'movie_card.dart';

class CategoryList extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const CategoryList({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  movie: movie,
                  onTap: () {
                    context.go('/detail', extra: movie.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
