import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import '../../domain/entities/movie.dart';
import 'package:flutter/material.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      BlocProvider.of<NowPlayingMoviesBloc>(context).add(OnFetchNowPlayingMovies());
      BlocProvider.of<PopularMovieBloc>(context).add(OnFetchPopularMovie());
      BlocProvider.of<TopRatedMovieBloc>(context).add(OnFetchTopRatedMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    Drawer menuDrawer(){
      return Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  homeTvSeriesRoute
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, watchlistMovieRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, watchlistTvSeriesRoute);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      );
    }

    Widget subHeading({required String title, required Function() onTap}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            onTap: onTap,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('See More'),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget nowPlayingSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now Playing',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: (context, state){
              if(state is NowPlayingMoviesLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is NowPlayingHasData){
                return MovieList(state.movies);
              }else{
                return const Text('Failed');
              }
            }
          )
        ],
      );
    }

    Widget popularSection(){
      return Column(
        children: [
          subHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(context, popularMoviesRoute)
          ),
          BlocBuilder<PopularMovieBloc, PopularMovieState>(
              builder: (context, state){
                if(state is PopularMovieLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is PopularMovieHasData){
                  return MovieList(state.popularMovies);
                }else{
                  return const Text('Failed');
                }
              }
          )
        ],
      );
    }

    Widget topRatedSection(){
      return Column(
        children: [
          subHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, topRatedRoute),
          ),
          BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
              builder: (context, state){
                if(state is TopRatedMovieLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is TopRatedMovieHasData){
                  return MovieList(state.topRatedMovies);
                }else{
                  return const Text('Failed');
                }
              }
          ),
        ],
      );
    }

    return Scaffold(
      drawer: menuDrawer(),
      appBar: AppBar(
        title: const Text('Movie'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchMovieRoute);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nowPlayingSection(),
              popularSection(),
              topRatedSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
