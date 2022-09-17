part of 'hot_and_new_bloc.dart';

@freezed
class HotAndNewState with _$HotAndNewState {
  const factory HotAndNewState({
    required final List<HotAndNewData> commingSoonList,
    required final List<HotAndNewData> everyOneIsWatchingList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;

  factory HotAndNewState.initial() => const HotAndNewState(
        commingSoonList: [],
        everyOneIsWatchingList: [],
        hasError: false,
        isLoading: false,
      );
}
