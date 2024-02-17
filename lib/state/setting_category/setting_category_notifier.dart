import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../utility/utility.dart';
import 'setting_category_state.dart';

////////////////////////////////////////////////
final settingCategoryProvider = StateNotifierProvider.autoDispose<
    SettingCategoryNotifier, SettingCategoryState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SettingCategoryNotifier(const SettingCategoryState(), client, utility);
});

class SettingCategoryNotifier extends StateNotifier<SettingCategoryState> {
  SettingCategoryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> setSelectedCategory1({required String value}) async =>
      state = state.copyWith(selectedCategory1: value);

  Future<void> setInputedCategory1({required String value}) async =>
      state = state.copyWith(inputedCategory1: value);

  Future<void> setSelectedCategory2({required String value}) async =>
      state = state.copyWith(selectedCategory2: value);

  Future<void> setInputedCategory2({required String value}) async =>
      state = state.copyWith(inputedCategory2: value);

  ///
  Future<void> inputCategory({required String bunrui}) async {
    final cate1 = (state.selectedCategory1 != '')
        ? state.selectedCategory1
        : state.inputedCategory1;

    final cate2 = (state.selectedCategory2 != '')
        ? state.selectedCategory2
        : state.inputedCategory2;

    if (cate1 == '' || cate2 == '') {
      state = state.copyWith(errorStr: 'category no set');
    }

    final uploadData = <String, dynamic>{};
    uploadData['bunrui'] = bunrui;
    uploadData['category1'] = cate1;
    uploadData['category2'] = cate2;

    await client
        .post(path: APIPath.updateYoutubeCategoryTree, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
