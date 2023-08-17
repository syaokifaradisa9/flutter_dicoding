import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/search/search_tv_series_bloc.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';

class SearchTvSeriesPage extends StatelessWidget {
  const SearchTvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvSeriesBloc>().add(
                  OnQueryTvSeriesChanged(query)
                );
              },
              decoration: const InputDecoration(
                hintText: 'Search Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
              builder: (context, state){
                if(state is SearchTvSeriesLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is SearchTvSeriesEmpty){
                  return const Center(
                    child: Text(
                      key: Key("empty-text"),
                      "Movie not found!"
                    ));
                }else if(state is SearchTvSeriesHasData){
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = state.tvSeries[index];
                        return TvSeriesCard(tvSeries);
                      },
                      itemCount: state.tvSeries.length,
                    )
                  );
                }else{
                  return const Text(
                    key: Key("error-text"),
                    'Failed'
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
