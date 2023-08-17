import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState>{
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieEmpty()){
    on<OnFetchPopularMovie>((event, emit) async{
      emit(PopularMovieLoading());

      final movies = await _getPopularMovies.execute();
      movies.fold((failure){
        emit(PopularMovieError(failure.message));
      }, (moviesData){
        if(moviesData.isNotEmpty){
          emit(PopularMovieHasData(moviesData));
        }else{
          emit(PopularMovieEmpty());
        }
      });
    });
  }
}