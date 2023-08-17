import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/genre.dart';
import 'package:movies/presentation/bloc/detail/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_status/watchlist_movie_status_bloc.dart';
import '../../domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailMovieBloc>(context).add(
        OnFetchMovieDetail(widget.id)
      );
      BlocProvider.of<WatchlistMovieStatusBloc>(context).add(
        OnFetchWatchlistStatus(widget.id)
      );
      BlocProvider.of<RecommendationMovieBloc>(context).add(
        OnFetchRecommendationMovie(widget.id)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state){
          if(state is DetailMovieLoading){
            return const Center(
              child: CircularProgressIndicator(
                key: Key('progress-detail')
              )
            );
          }else if(state is DetailMovieHasData){
            final movie = state.movie;
            return SafeArea(
              child: DetailContent(movie),
            );
          }else{
            return const Center(
              child: Text(
                key: Key('error-text'),
                'Failed'
              ),
            );
          }
        }
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  const DetailContent(this.movie, {Key? key}) : super(key: key);

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
        imageUrl: '$baseImageUrl${movie.posterPath}',
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
            movie.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          BlocConsumer<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
              listener: (context, state){
                if(state is WatchlistMovieStatusHasData){
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
                if(state is WatchlistMovieStatusHasData){
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
                        context.read<WatchlistMovieStatusBloc>().add(
                          OnRemoveFromWatchList(movie)
                        );
                      }else{
                        context.read<WatchlistMovieStatusBloc>().add(
                          OnAddedToWatchlist(movie)
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
          Text(_showGenres(movie.genres)),
          Text(_showDuration(movie.runtime)),
          Row(
            children: [
              RatingBarIndicator(
                rating: movie.voteAverage / 2,
                itemCount: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kMikadoYellow,
                ),
                itemSize: 24,
              ),
              Text('${movie.voteAverage}')
            ],
          )
        ],
      );
    }

    Widget overviewSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: Theme.of(context).textTheme.titleLarge),
          Text(movie.overview, textAlign: TextAlign.justify)
        ]
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
            child: BlocBuilder<RecommendationMovieBloc, RecommendationMovieState>(
                builder: (context, state){
                  if(state is RecommendationMovieLoading){
                    return const Center(child: CircularProgressIndicator());
                  }else if(state is RecommendationMovieHasData){
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final movie = state.recommendationMovie[index];
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
                                placeholder: (context, url) =>
                                const Center(
                                  child:
                                  CircularProgressIndicator(),
                                ),
                                errorWidget: (_, __, ___) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.recommendationMovie.length,
                    );
                  }else{
                    return const Center(
                      child: Text('Failed'),
                    );
                  }
                }
            ),
          ),
        ]
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
                            overviewSection(),
                            const SizedBox(height: 16),
                            recommendationSection()
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
