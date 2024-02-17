// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/category.dart';
import '../utility/utility.dart';

/*
bigCategoryProvider       List<Category>
smallCategoryProvider       List<Category>
bunruiProvider        List<Category>

bunruiMapProvider       Map<String, Map<String, String>>

categoryInputProvider       int
playedAtUpdateProvider        int
*/

////////////////////////////////////////////////
final bigCategoryProvider =
    StateNotifierProvider.autoDispose<BigCategoryNotifier, List<Category>>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BigCategoryNotifier([], client, utility)..getBigCategory();
});

class BigCategoryNotifier extends StateNotifier<List<Category>> {
  BigCategoryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBigCategory() async {
    await client.post(path: APIPath.getYoutubeCategoryTree).then((value) {
      final list = <Category>[];

      final getCategory = <String>[];
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final category1 = value['data'][i]['category1'].toString();

        //---
        if (!getCategory.contains(category1)) {
          list.add(
            Category(
              category1: value['data'][i]['category1'].toString(),
              category2: value['data'][i]['category2'].toString(),
              bunrui: value['data'][i]['bunrui'].toString(),
            ),
          );
        }

        getCategory.add(category1);
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final smallCategoryProvider = StateNotifierProvider.autoDispose
    .family<SmallCategoryNotifier, List<Category>, String>((ref, category1) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SmallCategoryNotifier([], client, utility)
    ..getSmallCategory(category1: category1);
});

class SmallCategoryNotifier extends StateNotifier<List<Category>> {
  SmallCategoryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSmallCategory({required String category1}) async {
    await client.post(path: APIPath.getYoutubeCategoryTree).then((value) {
      final list = <Category>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        //---
        if (category1 == value['data'][i]['category1']) {
          list.add(
            Category(
              category1: value['data'][i]['category1'].toString(),
              category2: value['data'][i]['category2'].toString(),
              bunrui: value['data'][i]['bunrui'].toString(),
            ),
          );
        }
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final bunruiProvider = StateNotifierProvider.autoDispose
    .family<BunruiNotifier, List<Category>, String>((ref, category2) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BunruiNotifier([], client, utility)..getBunrui(category2: category2);
});

class BunruiNotifier extends StateNotifier<List<Category>> {
  BunruiNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBunrui({required String category2}) async {
    await client.post(path: APIPath.getYoutubeCategoryTree).then((value) {
      final list = <Category>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        //---
        if (category2 == value['data'][i]['category2']) {
          list.add(
            Category(
              category1: value['data'][i]['category1'].toString(),
              category2: value['data'][i]['category2'].toString(),
              bunrui: value['data'][i]['bunrui'].toString(),
            ),
          );
        }
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final bunruiMapProvider = StateNotifierProvider.autoDispose<BunruiMapNotifier,
    Map<String, Map<String, String>>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BunruiMapNotifier({}, client, utility)..getBunruiMap();
});

class BunruiMapNotifier
    extends StateNotifier<Map<String, Map<String, String>>> {
  BunruiMapNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBunruiMap() async {
    await client.post(path: APIPath.getYoutubeCategoryTree).then((value) {
      final map = <String, Map<String, String>>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final bunrui = value['data'][i]['bunrui'].toString();
        final category1 = value['data'][i]['category1'].toString();
        final category2 = value['data'][i]['category2'].toString();
        map[bunrui] = {'category1': category1, 'category2': category2};
      }

      state = map;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final categoryInputProvider =
    StateNotifierProvider.autoDispose<CategoryInputStateNotifier, int>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CategoryInputStateNotifier(0, client, utility);
});

class CategoryInputStateNotifier extends StateNotifier<int> {
  CategoryInputStateNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> inputBunrui(
      {required String youtubeId,
      required String cate1,
      required String cate2,
      required String bunrui}) async {
    final uploadData = <String, dynamic>{};
    uploadData['bunrui'] = bunrui;
    uploadData['category1'] = cate1;
    uploadData['category2'] = cate2;
    uploadData['youtube_id'] = youtubeId;

    await client
        .post(path: APIPath.oneBunruiInput, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final playedAtUpdateProvider =
    StateNotifierProvider.autoDispose<PlayedAtUpdateStateNotifier, int>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return PlayedAtUpdateStateNotifier(0, client, utility);
});

class PlayedAtUpdateStateNotifier extends StateNotifier<int> {
  PlayedAtUpdateStateNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> updateVideoPlayedAt({required String youtubeId}) async {
    final uploadData = <String, dynamic>{};
    uploadData['date'] = DateTime.now().yyyymmdd;
    uploadData['youtube_id'] = youtubeId;

    await client
        .post(path: APIPath.updateVideoPlayedAt, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
