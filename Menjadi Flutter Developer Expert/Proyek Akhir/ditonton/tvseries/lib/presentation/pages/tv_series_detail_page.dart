import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/domain/entities/genre.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/presentation/bloc/detail/detail_tv_series_bloc.dart';
import 'package:tvseries/presentation/bloc/recommendation/recommendation_tv_series_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist_status/watchlist_tv_series_status_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;
  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailTvSeriesBloc>(context).add(
        OnFetchTvSeriesDetail(widget.id)
      );
      BlocProvider.of<WatchlistTvSeriesStatusBloc>(context).add(
        OnFetchWatchlistStatus(widget.id)
      );
      BlocProvider.of<RecommendationTvSeriesBloc>(context).add(
        OnFetchRecommendationTvSeries(widget.id)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
        builder: (context, state){
          if(state is DetailTvSeriesLoading){
            return const Center(child: CircularProgressIndicator());
          }else if(state is DetailTvSeriesHasData){
            final tvSeries = state.tvSeries;
            return SafeArea(
              child: DetailContent(tvSeries),
            );
          }else{
            return const Text('Failed');
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  const DetailContent(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget backButton(){
      return CircleAvatar(
        backgroundColor: kRichBlack,
        foregroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    Widget backgroundImageSection(){
      return CachedNetworkImage(
        imageUrl: '$baseImageUrl${tvSeries.posterPath}',
        width: screenWidth,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    Widget headerSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tvSeries.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          BlocConsumer<WatchlistTvSeriesStatusBloc, WatchlistTvSeriesStatusState>(
            listener: (context, state){
              if(state is WatchlistTvSeriesStatusHasData){
                if(state.message.isNotEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      duration: const Duration(milliseconds: 700)
                    )
                  );
                }
              }
            },
            builder: (context, state){
              if(state is WatchlistTvSeriesStatusHasData){
                return ElevatedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(state.isAdded ? Icons.check : Icons.add),
                      const Text('Watchlist'),
                    ],
                  ),
                  onPressed: (){
                    if(state.isAdded){
                      context.read<WatchlistTvSeriesStatusBloc>().add(
                        OnRemoveFromWatchList(tvSeries)
                      );
                    }else{
                      context.read<WatchlistTvSeriesStatusBloc>().add(
                        OnAddedToWatchlist(tvSeries)
                      );
                    }
                  },
                );
              }else{
                return const Center(
                  child: CircularProgressIndicator()
                );
              }
            }
          ),
          Text(_showGenres(tvSeries.genres)),
          Row(
            children: [
              RatingBarIndicator(
                rating: tvSeries.voteAverage / 2,
                itemCount: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kMikadoYellow,
                ),
                itemSize: 24,
              ),
              Text('${tvSeries.voteAverage}')
            ],
          )
        ],
      );
    }

    Widget tvSeriesInformationSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: Theme.of(context).textTheme.titleLarge
          ),
          Text(tvSeries.overview),
          const SizedBox(height: 16),
          Text(
            'Number of Episode',
            style: Theme.of(context).textTheme.titleLarge
          ),
          Text("${tvSeries.numberOfEpisode.toString()} Episode"),
          const SizedBox(height: 16),
          Text(
            'Last Episode',
            style: Theme.of(context).textTheme.titleLarge
          ),
          Text(
            "Episode ${tvSeries.lastEpisode.episodeNumber}"
            " in season ${tvSeries.lastEpisode.seasonNumber}"
            " \n${tvSeries.overview}"
          ),
          const SizedBox(height: 16),
          Text(
            'Homepage',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(tvSeries.homepage),
        ],
      );
    }

    Widget seasonSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seasons (${tvSeries.numberOfSeason.toString()})',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tvSeries.seasons.length,
              itemBuilder: (context, index) {
                final tvSeriesSeason = tvSeries.seasons[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        tvDetailRoute,
                        arguments: tvSeriesSeason.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        '$baseImageUrl${tvSeriesSeason.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget recommendationSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommendations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 150,
            child: BlocBuilder<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
                builder: (context, state){
                  if(state is RecommendationTvSeriesLoading){
                    return const Center(child: CircularProgressIndicator());
                  }else if(state is RecommendationTvSeriesHasData){
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final movie = state.recommendationTvSeries[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                movieDetailRoute,
                                arguments: movie.id,
                              );
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                '$baseImageUrl${movie.posterPath}',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()
                                ),
                                errorWidget: (context, url, error) => const Center(
                                  child: Icon(Icons.error)
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.recommendationTvSeries.length,
                    );
                  }else{
                    return const Center(
                      child: Text('Failed'),
                    );
                  }
                }
            ),
          )
        ],
      );
    }

    return Stack(
      children: [
        backgroundImageSection(),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerSection(),
                            const SizedBox(height: 16),
                            tvSeriesInformationSection(),
                            const SizedBox(height: 16),
                            seasonSection(),
                            const SizedBox(height: 16),
                            recommendationSection(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: backButton()
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    return genres.map((e) => e.name).toList().join(', ');
  }
}
