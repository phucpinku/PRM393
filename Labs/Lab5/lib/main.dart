import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: const Color(0xFFF7F2FA),
        useMaterial3: true,
      ),
      home: const MovieListScreen(),
    );
  }
}

class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });

  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<Trailer> trailers;
}

class Trailer {
  const Trailer({required this.title});

  final String title;
}

const movies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl:
        'https://images.unsplash.com/photo-1604519652476-2c9fa9ee9d37?auto=format&fit=crop&w=900&q=80',
    overview:
        'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: [
      Trailer(title: 'Official Trailer #1'),
      Trailer(title: 'IMAX Sneak Peek'),
    ],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl:
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=900&q=80',
    overview:
        'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: [
      Trailer(title: 'Red Band Trailer'),
      Trailer(title: 'Behind the Scenes'),
    ],
  ),
];

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 24),
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(left: 2, bottom: 42),
                child: Text(
                  'Movies',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D2932),
                  ),
                ),
              );
            }

            final movie = movies[index - 1];
            return MovieCard(movie: movie);
          },
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 26),
      color: const Color(0xFFF1EEF7),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE8E1EC)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 14, 32),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MovieImage(
                  imageUrl: movie.posterUrl,
                  width: 96,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF26232A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '☆ ${movie.rating.toStringAsFixed(1)} • ${movie.genres.join(', ')}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5F5A66),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                size: 34,
                color: Color(0xFF49454F),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: const Color(0xFFF7F2FA),
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          MovieHeroBanner(movie: movie),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final genre in movie.genres)
                  Chip(
                    label: Text(genre),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: const Color(0xFFF8F6FB),
                    side: const BorderSide(color: Color(0xFFD7CFDC)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
            child: Text(
              movie.overview,
              style: const TextStyle(
                fontSize: 14,
                height: 1.35,
                color: Color(0xFF49454F),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 4, 32, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MovieActionButton(
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  label: 'Favorite',
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
                MovieActionButton(
                  icon: Icons.star,
                  label: 'Rate',
                  onPressed: () {},
                ),
                MovieActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Trailers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D2932),
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final trailer in movie.trailers) TrailerTile(trailer: trailer),
        ],
      ),
    );
  }
}

class MovieHeroBanner extends StatelessWidget {
  const MovieHeroBanner({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MovieImage(
            imageUrl: movie.posterUrl,
            width: double.infinity,
            height: 175,
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC000000)],
              ),
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 14,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieActionButton extends StatelessWidget {
  const MovieActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          color: const Color(0xFF3D3843),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF49454F)),
        ),
      ],
    );
  }
}

class TrailerTile extends StatelessWidget {
  const TrailerTile({super.key, required this.trailer});

  final Trailer trailer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ListTile(
        dense: true,
        minLeadingWidth: 24,
        leading: const Icon(
          Icons.play_circle_fill,
          size: 20,
          color: Color(0xFF49454F),
        ),
        title: Text(
          trailer.title,
          style: const TextStyle(fontSize: 13, color: Color(0xFF49454F)),
        ),
        shape: const Border(bottom: BorderSide(color: Color(0xFFD7CFDC))),
      ),
    );
  }
}

class MovieImage extends StatelessWidget {
  const MovieImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.fit,
  });

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: const Color(0xFF2F2A34),
          alignment: Alignment.center,
          child: const Icon(Icons.movie, color: Colors.white70),
        );
      },
    );
  }
}
