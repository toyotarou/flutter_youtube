import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import 'app_param_state.dart';

////////////////////////////////////////////////
final appParamProvider =
    StateNotifierProvider.autoDispose<AppParamNotifier, AppParamState>((ref) {
  final year = DateTime.now().yyyy;

  return AppParamNotifier(
    AppParamState(
      selectedBunrui: '',
      youtubeIdList: [],
      selectedYear: year,
      searchText: '',
    ),
  );
});

class AppParamNotifier extends StateNotifier<AppParamState> {
  AppParamNotifier(super.state);

  ///
  Future<void> setSelectedBunrui(
          {required String category2, required String bunrui}) async =>
      state = state.copyWith(selectedBunrui: '$category2|$bunrui');

  ///
  Future<void> setYoutubeIdList({required String youtubeId}) async {
    final youtubeIdList = [...state.youtubeIdList];

    if (youtubeIdList.contains(youtubeId)) {
      final list = <String>[];
      youtubeIdList.forEach((element) {
        if (element != youtubeId) {
          list.add(element);
        }
      });
      state = state.copyWith(youtubeIdList: list);
    } else {
      youtubeIdList.add(youtubeId);
      state = state.copyWith(youtubeIdList: youtubeIdList);
    }
  }

  ///
  Future<void> clearYoutubeIdList() async {
    state = state.copyWith(youtubeIdList: []);
  }

  ///
  Future<void> setSelectedYear({required String year}) async =>
      state = state.copyWith(selectedYear: year);

  ///
  Future<void> setSearchText({required String text}) async =>
      state = state.copyWith(searchText: text);
}

////////////////////////////////////////////////
