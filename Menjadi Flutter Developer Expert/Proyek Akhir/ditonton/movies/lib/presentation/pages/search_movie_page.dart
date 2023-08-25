import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/search/search_movies_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

class SearchMoviePage extends StatelessWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchMovieBloc>().add(OnQueryMovieChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
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
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state){
                if(state is SearchMovieLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is SearchMovieEmpty){
                  return const Center(
                    child: Text(
                      key: Key("empty-text"),
                      "Movie not found!"
                    ));
                }else if(state is SearchMovieHasData){
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.movies.length,
                    )
                  );
                }else{
                  return const Text(
                    key: Key("error-text"),
                    'Failed'
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
