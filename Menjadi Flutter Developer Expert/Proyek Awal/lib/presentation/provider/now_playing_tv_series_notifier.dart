import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/tv_series.dart';

class NowPlayingTvSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesNotifier({ required this.getNowPlayingTvSeries });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (tvSeriesData) {
      _tvSeries = tvSeriesData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
