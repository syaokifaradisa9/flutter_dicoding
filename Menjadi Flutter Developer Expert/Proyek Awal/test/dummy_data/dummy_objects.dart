import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/creator.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/network_channel.dart';
import 'package:ditonton/domain/entities/production_company.dart';
import 'package:ditonton/domain/entities/production_country.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// TV SERIES

final testTvSeries = TvSeries(
    id: 1,
    name: 'name',
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['originCountry'],
    genreIds: [1],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    popularity: 1,
    voteAverage: 1,
    voteCount: 1,
    posterPath: 'posterPath',
    backdropPath: 'backdropPath'
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesTable = const TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview'
);

final testMovieTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'poster_path': 'posterPath',
  'overview': 'overview',
};

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'backdropPath',
    country: ['country'],
    creators: [
      Creator(
          id: 1,
          creditId: "creditId",
          name: 'name',
          gender: 1,
          profilePath: 'profilePath'
      )
    ],
    episodeRunTime: [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    languages: ['language'],
    lastAirDate: 'lastAirDate',
    lastEpisode: LastEpisode(
        id: 1,
        airDate: 'airDate',
        episodeNumber: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1
    ),
    voteCount: 1,
    voteAverage: 1,
    overview: 'overview',
    name: 'name',
    networks: [
      NetworkChannel(
          id: 1, name: 'name', country: 'country', logoPath: 'logoPath')
    ],
    numberOfEpisode: 1,
    numberOfSeason: 1,
    originalName: 'originamName',
    originLanguage: 'originLanguage',
    popularity: 1,
    posterPath: 'posterPath',
    productionCompanies: [
      ProductionCompany(
          id: 'id', name: 'name', country: 'country', logoPath: 'logoPath')
    ],
    productionCountries: [ProductionCountry(code: 'code', name: 'name')],
    seasons: [
      Season(
          id: 1, name: 'name', posterPath: 'posterPath',
          seasonNumber: 1, overview: 'overview', airDate: 'airDate',
          episodeCount: 1)
    ],
    spokenLanguages: [
      SpokenLanguage(
          name: 'name', code: 'code', englishName: 'englishName')
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type'
);