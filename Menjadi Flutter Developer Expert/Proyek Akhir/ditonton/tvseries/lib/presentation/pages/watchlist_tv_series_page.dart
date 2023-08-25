import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  const WatchlistTvSeriesPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<WatchlistTvSeriesBloc>(context).add(
      OnFetchWatchlistTvSeries()
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() => BlocProvider.of<WatchlistTvSeriesBloc>(context).add(
      OnFetchWatchlistTvSeries()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          builder: (context, state){
            if(state is WatchlistTvSeriesHasData){
              return ListView.builder(
                itemCount: state.tvSeries.length,
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeries[index];
                  return TvSeriesCard(tvSeries);
                }
              );
            }else if(state is WatchlistTvSeriesLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state is WatchlistTvSeriesEmpty){
              return const Center(
                child: Text(
                  key: Key("empty-text"),
                  "Watchlist Tv Series Empty!"
                ),
              );
            }else{
              return const Text(
                key: Key("error-text"),
                'Failed'
              );
            }
          }
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
