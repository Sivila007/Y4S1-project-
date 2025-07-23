import '../models/movie.dart';

final List<Movie> mockMovies = [
  Movie(
    id: '1',
    title: 'Dune: Part Two',
    year: 2024,
    genre: 'Sci-Fi',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
    rating: 4.8,
    description:
        'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    cast: ['Timothée Chalamet', 'Zendaya', 'Rebecca Ferguson'],
    relatedMovieIds: ['2', '3'],
  ),
  Movie(
    id: '2',
    title: 'Oppenheimer',
    year: 2023,
    genre: 'Biography',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/ptpr0kGAckfQkJeJIt8st5dglvd.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
    rating: 4.7,
    description:
        'The story of J. Robert Oppenheimer and the creation of the atomic bomb during World War II.',
    cast: ['Cillian Murphy', 'Emily Blunt', 'Matt Damon'],
    relatedMovieIds: ['1', '4'],
  ),
  Movie(
    id: '3',
    title: 'The Batman',
    year: 2022,
    genre: 'Action',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w780/6ELCZlTA5lGUops70hKdB83WJxH.jpg',
    rating: 4.6,
    description:
        'Batman ventures into Gotham City’s underworld when a sadistic killer leaves behind a trail of cryptic clues.',
    cast: ['Robert Pattinson', 'Zoë Kravitz', 'Colin Farrell'],
    relatedMovieIds: ['1', '5'],
  ),
  Movie(
    id: '4',
    title: 'Everything Everywhere All at Once',
    year: 2022,
    genre: 'Adventure',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w780/9bbxqz1iPEfZN9Xi2ZjJhkp5JRo.jpg',
    rating: 4.9,
    description:
        'An aging Chinese immigrant is swept up in an insane adventure, where she alone can save the world by exploring other universes.',
    cast: ['Michelle Yeoh', 'Stephanie Hsu', 'Ke Huy Quan'],
    relatedMovieIds: ['2', '6'],
  ),
  Movie(
    id: '5',
    title: 'Avatar: The Way of Water',
    year: 2022,
    genre: 'Adventure',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w780/2va32apQP97gvUxaMnL5wYt4CRB.jpg',
    rating: 4.5,
    description:
        'Jake Sully lives with his newfound family formed on the planet of Pandora. Once a familiar threat returns, Jake must fight a difficult war.',
    cast: ['Sam Worthington', 'Zoe Saldana', 'Sigourney Weaver'],
    relatedMovieIds: ['3', '6'],
  ),
  Movie(
    id: '6',
    title: 'Top Gun: Maverick',
    year: 2022,
    genre: 'Action',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w780/2rs1B6lR2tJxgq4Bz1z1b8z1b8z.jpg',
    rating: 4.8,
    description:
        'After more than thirty years of service as one of the Navy’s top aviators, Pete Mitchell is where he belongs, pushing the envelope as a courageous test pilot.',
    cast: ['Tom Cruise', 'Miles Teller', 'Jennifer Connelly'],
    relatedMovieIds: ['4', '5'],
  ),
];
