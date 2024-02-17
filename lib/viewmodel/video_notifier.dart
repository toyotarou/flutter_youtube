// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/special_video.dart';
import '../models/video.dart';
import '../state/app_param/app_param_notifier.dart';
import '../state/app_param/app_param_state.dart';
import '../utility/utility.dart';

/*
videoListProvider       List<Video>
videoHistoryProvider        List<Video>
blankBunruiVideoProvider        List<Video>

specialVideoProvider        List<SpecialVideo>

videoManipulateProvider       int
*/

////////////////////////////////////////////////
final videoListProvider = StateNotifierProvider.autoDispose<VideoListNotifier, List<Video>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return VideoListNotifier([], client, utility);
});

class VideoListNotifier extends StateNotifier<List<Video>> {
  VideoListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getVideoList({required String bunrui}) async {
    await client.post(path: APIPath.getYoutubeList, body: {'bunrui': bunrui}).then((value) {
      final list = <Video>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Video.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final videoHistoryProvider = StateNotifierProvider.autoDispose<VideoHistoryStateNotifier, List<Video>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return VideoHistoryStateNotifier([], client, utility)..getVideoData();
});

class VideoHistoryStateNotifier extends StateNotifier<List<Video>> {
  VideoHistoryStateNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getVideoData() async {
    await client.post(path: APIPath.getYoutubeList).then((value) {
      final list = <Video>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Video.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final blankBunruiVideoProvider = StateNotifierProvider.autoDispose<BlankBunruiVideoStateNotifier, List<Video>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BlankBunruiVideoStateNotifier([], client, utility)..getBlankBunruiVideo();
});

class BlankBunruiVideoStateNotifier extends StateNotifier<List<Video>> {
  BlankBunruiVideoStateNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBlankBunruiVideo() async {
    await client.post(path: APIPath.getBlankBunruiVideo).then((value) {
      final list = <Video>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Video.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

/// special
////////////////////////////////////////////////

final specialVideoProvider = StateNotifierProvider.autoDispose<SpecialVideoStateNotifier, List<SpecialVideo>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpecialVideoStateNotifier([], client, utility)..getSpecialVideo();
});

class SpecialVideoStateNotifier extends StateNotifier<List<SpecialVideo>> {
  SpecialVideoStateNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getSpecialVideo() async {
    await client.post(path: APIPath.getSpecialVideo).then((value) {
      final list = <SpecialVideo>[];
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final list2 = <Video>[];
        for (var j = 0; j < value['data'][i]['item'].length.toString().toInt(); j++) {
          list2.add(Video.fromJson(value['data'][i]['item'][j] as Map<String, dynamic>));
        }

        list.add(
          SpecialVideo(
            bunrui: value['data'][i]['bunrui'].toString(),
            count: value['data'][i]['count'].toString().toInt(),
            item: list2,
          ),
        );
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
final videoManipulateProvider = StateNotifierProvider.autoDispose<VideoManipulateNotifier, int>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  final appParamState = ref.watch(appParamProvider);

  return VideoManipulateNotifier(0, client, utility, appParamState);
});

class VideoManipulateNotifier extends StateNotifier<int> {
  VideoManipulateNotifier(super.state, this.client, this.utility, this.appParamState);

  final HttpClient client;
  final Utility utility;
  final AppParamState appParamState;

  ///
  Future<void> videoManipulate({required String flag}) async {
    final list = <String>[];
    appParamState.youtubeIdList.forEach((element) {
      list.add("'$element'");
    });

    await client
        .post(
          path: APIPath.bunruiYoutubeData,
          body: {
            'bunrui': flag,
            'youtube_id': list.join(','),
          },
        )
        .then((value) {})
        .catchError((error, _) {
          utility.showError('予期せぬエラーが発生しました');
        });
  }
}
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
