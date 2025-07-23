import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/datasources/mock_movies.dart';
import '../../../data/models/movie.dart';
import '../widgets/cast_list.dart';
import '../widgets/related_movies.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with SingleTickerProviderStateMixin {
  late final Movie movie;
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    movie = mockMovies.firstWhere(
      (m) => m.id == widget.movieId,
      orElse: () => mockMovies.first,
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideIn = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Backdrop
            Hero(
              tag: 'featured-movie-${movie.id}',
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 260,
                    child: Image.network(
                      movie.backdropUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: const Center(
                            child: Icon(
                              Icons.movie_rounded,
                              size: 64,
                              color: Colors.white54,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[800],
                          child: const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 260,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Animated Content
            FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideIn,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('${movie.year}',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70)),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              movie.genre,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          Text('${movie.rating}',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        movie.description,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      // Watch Now Button (full-width, left-aligned)
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.push('/movie/${movie.id}/play');
                          },
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Watch Now'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            backgroundColor: const Color(0xFF667EEA),
                            foregroundColor: Colors.white,
                            textStyle: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 6,
                            shadowColor:
                                const Color(0xFF667EEA).withOpacity(0.4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text('Cast',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: Colors.white)),
                      const SizedBox(height: 12),
                      CastList(cast: movie.cast),
                      const SizedBox(height: 24),
                      Text('Related Movies',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: Colors.white)),
                      const SizedBox(height: 12),
                      RelatedMovies(
                        movies: mockMovies
                            .where((m) =>
                                m.id != movie.id &&
                                movie.relatedMovieIds.contains(m.id))
                            .toList(),
                        onTap: (related) {
                          context.push('/movie/${related.id}');
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
