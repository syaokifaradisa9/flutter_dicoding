import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tvseries/tvseries.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Now Playing
        BlocProvider(create: (_) => di.locator<NowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingTvSeriesBloc>()),

        // Detail
        BlocProvider(create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<DetailTvSeriesBloc>()),

        // Recommendation
        BlocProvider(create: (_) => di.locator<RecommendationMovieBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationTvSeriesBloc>()),

        // Watchlist Status
        BlocProvider(create: (_) => di.locator<WatchlistMovieStatusBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvSeriesStatusBloc>()),

        // Search
        BlocProvider(create: (_) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvSeriesBloc>()),

        // Top rated
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvSeriesBloc>()),

        // Popular
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvSeriesBloc>()),

        // Watchlist
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvSeriesBloc>()),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homeMoviesRoute:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case homeTvSeriesRoute:
              return MaterialPageRoute(builder: (_) => HomeTvSeriesPage());
            case popularMoviesRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case nowPlayingTvSeriesRoute:
              return CupertinoPageRoute(builder: (_) => NowPlayingTvSeriesPage());
            case popularTvSeriesRoute:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case topRatedRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case topRatedTvRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case tvDetailRoute :
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings
              );
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case searchTvRoute:
              return CupertinoPageRoute(builder: (_) => SearchTvSeriesPage());
            case watchlistMovieRoute:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case watchlistTvSeriesRoute:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
