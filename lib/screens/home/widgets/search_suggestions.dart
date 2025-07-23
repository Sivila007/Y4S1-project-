import 'package:flutter/material.dart';

class SearchSuggestions extends StatefulWidget {
  final Function(String) onSuggestionTap;
  const SearchSuggestions({Key? key, required this.onSuggestionTap})
      : super(key: key);

  @override
  State<SearchSuggestions> createState() => _SearchSuggestionsState();
}

class _SearchSuggestionsState extends State<SearchSuggestions>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  String? _hoveredChip;

  final List<String> _popularSearches = [
    'Dune',
    'Avatar',
    'Oppenheimer',
    'Top Gun',
    'Marvel',
    'Batman'
  ];

  final List<String> _genres = [
    'Action',
    'Sci-Fi',
    'Adventure',
    'Biography',
    'Comedy',
    'Drama',
    'Horror',
    'Romance'
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Popular Searches', Icons.trending_up),
            const SizedBox(height: 16),
            _buildChipGrid(_popularSearches),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Browse by Genre', Icons.category),
            const SizedBox(height: 16),
            _buildChipGrid(_genres),
            const SizedBox(height: 24),
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF667EEA),
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildChipGrid(List<String> items) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 300 + index * 50),
          builder: (context, value, child) => Transform.scale(
            scale: value,
            child: child,
          ),
          child: _buildSuggestionChip(item),
        );
      }).toList(),
    );
  }

  Widget _buildSuggestionChip(String text) {
    final isHovered = _hoveredChip == text;
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredChip = text),
      onExit: (_) => setState(() => _hoveredChip = null),
      child: GestureDetector(
        onTap: () => widget.onSuggestionTap(text),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFF667EEA)
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered
                  ? const Color(0xFF667EEA)
                  : Theme.of(context).dividerColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isHovered
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF667EEA).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: Color(0xFF667EEA),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tip: Search by movie title, actor name, or genre',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withOpacity(0.7),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
