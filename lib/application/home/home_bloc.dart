import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new_resp/hot_and_new_service.dart';

import '../../domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //get home screen data
    on<GetHomeScreenData>((event, emit) async {
      //sent loading to UI
      emit(state.copyWith(isLoading: true, hasError: false));

      //get Data
      final _movieResult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTvData();

      //transform data
      final _state1 = _movieResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendigMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          final pastYear = resp.results;
          pastYear.shuffle();
          final trending = resp.results;
          trending.shuffle();
          final dramas = resp.results;
          dramas.shuffle();
          final southIndian = resp.results;

          southIndian.shuffle();

          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            trendigMovieList: trending,
            tenseDramasMovieList: dramas,
            southIndianMovieList: southIndian,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(_state1);

      final _state2 = _tvResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendigMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          final top10List = resp.results;
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            trendigMovieList: state.trendigMovieList,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: top10List,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(_state2);

      //sent to UI
    });
  }
}
