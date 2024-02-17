import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_category_state.freezed.dart';

@freezed
class SettingCategoryState with _$SettingCategoryState {
  const factory SettingCategoryState({
    @Default('') String errorStr,
    @Default('') String selectedCategory1,
    @Default('') String inputedCategory1,
    @Default('') String selectedCategory2,
    @Default('') String inputedCategory2,
  }) = _SettingCategoryState;
}
