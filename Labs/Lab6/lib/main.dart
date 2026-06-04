import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Browser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE53935),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

class Movie {
  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });

  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;
}

const List<Movie> allMovies = [
  Movie(
    title: 'Stellar Horizon',
    year: 2025,
    genres: ['Sci-Fi', 'Action'],
    posterUrl: 'https://picsum.photos/seed/stellar-horizon/400/600',
    rating: 8.8,
  ),
  Movie(
    title: 'Laugh Track',
    year: 2023,
    genres: ['Comedy'],
    posterUrl: 'https://picsum.photos/seed/laugh-track/400/600',
    rating: 7.4,
  ),
  Movie(
    title: 'Silent Harbor',
    year: 2021,
    genres: ['Drama', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/silent-harbor/400/600',
    rating: 8.1,
  ),
  Movie(
    title: 'Neon Chase',
    year: 2024,
    genres: ['Action', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/neon-chase/400/600',
    rating: 8.5,
  ),
  Movie(
    title: 'Paper Moons',
    year: 2020,
    genres: ['Drama', 'Romance'],
    posterUrl: 'https://picsum.photos/seed/paper-moons/400/600',
    rating: 7.8,
  ),
  Movie(
    title: 'Pixel Kingdom',
    year: 2022,
    genres: ['Animation', 'Comedy'],
    posterUrl: 'https://picsum.photos/seed/pixel-kingdom/400/600',
    rating: 8.0,
  ),
];

const List<String> movieGenres = [
  'Action',
  'Drama',
  'Comedy',
  'Sci-Fi',
  'Thriller',
  'Romance',
  'Animation',
];

enum MovieSort {
  az('A-Z'),
  za('Z-A'),
  year('Year'),
  rating('Rating');

  const MovieSort(this.label);

  final String label;
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final Set<String> _selectedGenres = {};
  String _searchQuery = '';
  MovieSort _selectedSort = MovieSort.az;

  List<Movie> get _visibleMovies {
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final movies = allMovies.where((movie) {
      final matchesSearch =
          normalizedQuery.isEmpty ||
          movie.title.toLowerCase().contains(normalizedQuery);
      final matchesGenre =
          _selectedGenres.isEmpty ||
          movie.genres.any(_selectedGenres.contains);
      return matchesSearch && matchesGenre;
    }).toList();

    switch (_selectedSort) {
      case MovieSort.az:
        movies.sort((a, b) => a.title.compareTo(b.title));
      case MovieSort.za:
        movies.sort((a, b) => b.title.compareTo(a.title));
      case MovieSort.year:
        movies.sort((a, b) => b.year.compareTo(a.year));
      case MovieSort.rating:
        movies.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return movies;
  }

  bool get _hasActiveFilters =>
      _searchQuery.trim().isNotEmpty || _selectedGenres.isNotEmpty;

  void _toggleGenre(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedGenres.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth >= 800;
    final horizontalPadding = isWideScreen ? 32.0 : 16.0;
    final visibleMovies = _visibleMovies;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            20,
            horizontalPadding,
            12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find a Movie',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Browse by title, genre, year, and rating.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 18),
              _SearchField(
                initialValue: _searchQuery,
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
              const SizedBox(height: 14),
              _GenreSelector(
                selectedGenres: _selectedGenres,
                onSelected: _toggleGenre,
              ),
              const SizedBox(height: 12),
              _SortBar(
                count: visibleMovies.length,
                selectedSort: _selectedSort,
                selectedGenreCount: _selectedGenres.length,
                hasActiveFilters: _hasActiveFilters,
                onSortChanged: (sort) {
                  if (sort == null) {
                    return;
                  }
                  setState(() => _selectedSort = sort);
                },
                onClearFilters: _clearFilters,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (visibleMovies.isEmpty) {
                      return const _EmptyState();
                    }

                    if (constraints.maxWidth >= 800) {
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.8,
                        children: [
                          for (final movie in visibleMovies)
                            MovieCard(movie: movie),
                        ],
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return MovieCard(movie: visibleMovies[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemCount: visibleMovies.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    required this.initialValue,
    required this.onChanged,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search movies',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class _GenreSelector extends StatelessWidget {
  const _GenreSelector({
    required this.selectedGenres,
    required this.onSelected,
  });

  final Set<String> selectedGenres;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final genre in movieGenres)
          FilterChip(
            label: Text(genre),
            selected: selectedGenres.contains(genre),
            onSelected: (_) => onSelected(genre),
            selectedColor: const Color(0xFFFFDAD6),
            checkmarkColor: const Color(0xFFBA1A1A),
            backgroundColor: Colors.white,
            side: BorderSide(
              color: selectedGenres.contains(genre)
                  ? const Color(0xFFE53935)
                  : Colors.black12,
            ),
          ),
      ],
    );
  }
}

class _SortBar extends StatelessWidget {
  const _SortBar({
    required this.count,
    required this.selectedSort,
    required this.selectedGenreCount,
    required this.hasActiveFilters,
    required this.onSortChanged,
    required this.onClearFilters,
  });

  final int count;
  final MovieSort selectedSort;
  final int selectedGenreCount;
  final bool hasActiveFilters;
  final ValueChanged<MovieSort?> onSortChanged;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$count results',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        if (selectedGenreCount > 0)
          Chip(
            visualDensity: VisualDensity.compact,
            avatar: const Icon(Icons.local_offer_outlined, size: 16),
            label: Text('$selectedGenreCount selected'),
          ),
        DropdownButton<MovieSort>(
          value: selectedSort,
          underline: const SizedBox.shrink(),
          borderRadius: BorderRadius.circular(12),
          items: [
            for (final sort in MovieSort.values)
              DropdownMenuItem(
                value: sort,
                child: Text('Sort: ${sort.label}'),
              ),
          ],
          onChanged: onSortChanged,
        ),
        if (hasActiveFilters)
          TextButton.icon(
            onPressed: onClearFilters,
            icon: const Icon(Icons.close, size: 18),
            label: const Text('Clear filters'),
          ),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;
        final posterWidth = compact ? 96.0 : 124.0;
        final posterHeight = compact ? 136.0 : 156.0;

        return Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE5E2DA)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    movie.posterUrl,
                    width: posterWidth,
                    height: posterHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: posterWidth,
                        height: posterHeight,
                        color: const Color(0xFFEAE7DF),
                        alignment: Alignment.center,
                        child: const Icon(Icons.movie_outlined),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${movie.year}',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.genres.join(' / '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: Color(0xFFFFB300),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.movie_filter_outlined, size: 48),
          const SizedBox(height: 12),
          Text(
            'No movies found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text('Try another search or genre.'),
        ],
      ),
    );
  }
}
