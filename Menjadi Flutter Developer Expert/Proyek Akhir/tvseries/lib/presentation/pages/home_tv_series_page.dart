import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/presentation/bloc/now_playing/now_playing_tv_series_bloc.dart';
import 'package:tvseries/presentation/bloc/popular/popular_tv_series_bloc.dart';
import 'package:tvseries/presentation/bloc/top_rated/top_rated_tv_series_bloc.dart';
import 'package:flutter/material.dart';

class HomeTvSeriesPage extends StatefulWidget {
  const HomeTvSeriesPage({Key? key}) : super(key: key);

  @override
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      BlocProvider.of<NowPlayingTvSeriesBloc>(context).add(OnFetchNowPlayingTvSeries());
      BlocProvider.of<PopularTvSeriesBloc>(context).add(OnFetchPopularTvSeries());
      BlocProvider.of<TopRatedTvSeriesBloc>(context).add(OnFetchTopRatedTvSeries());
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
                Navigator.pushReplacementNamed(
                    context,
                    homeMoviesRoute
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
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

    Widget searchButton(){
      return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, searchTvRoute);
        },
        icon: const Icon(Icons.search),
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
                children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
              ),
            ),
          ),
        ],
      );
    }

    Widget nowPlayingSection(){
      return Column(
        children: [
          subHeading(
            title: 'Now Playing',
            onTap: () => Navigator.pushNamed(
                context,
                nowPlayingTvSeriesRoute
            ),
          ),
          BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
              builder: (context, state){
                if(state is NowPlayingTvSeriesLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is NowPlayingHasData){
                  return TvSeriesList(state.tvSeries);
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
            onTap: () => Navigator.pushNamed(context, popularTvSeriesRoute),
          ),
          BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
              builder: (context, state){
                if(state is PopularTvSeriesLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is PopularTvSeriesHasData){
                  return TvSeriesList(state.popularMovies);
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
            onTap: () => Navigator.pushNamed(context, topRatedTvRoute),
          ),
          BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
            builder: (context, state){
              if(state is TopRatedTvSeriesLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is TopRatedTvSeriesHasData){
                return TvSeriesList(state.topRatedTvSeries);
              }else{
                return const Text('Failed');
              }
            },
          )
        ],
      );
    }

    return Scaffold(
      drawer: menuDrawer(),
      appBar: AppBar(
        title: const Text('Tv Series'),
        actions: [
          searchButton()
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

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;
  const TvSeriesList(this.tvSeriesList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
