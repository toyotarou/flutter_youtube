import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_param_state.freezed.dart';

@freezed
class AppParamState with _$AppParamState {
  const factory AppParamState({
    required String selectedBunrui,
    required List<String> youtubeIdList,
    required String selectedYear,
    required String searchText,
  }) = _AppParamState;
}
