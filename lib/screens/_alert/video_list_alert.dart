// ignore_for_file: must_be_immutable, cascade_invocations, use_decorated_box

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';
import '../../viewmodel/video_notifier.dart';
import '../_parts/video_list_item.dart';

class VideoListAlert extends ConsumerWidget {
  VideoListAlert({super.key, required this.category2});

  final String category2;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final deviceInfoState = ref.read(deviceInfoProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {});

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Text(category2),
              displayBunrui(),
              manipulateButton(),
              const SizedBox(height: 10),
              Expanded(child: displayVideoList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBunrui() {
    final appParamState = _ref.watch(appParamProvider);

    final bunruiState = _ref.watch(bunruiProvider(category2));

    final list = <Widget>[];

    bunruiState.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
            ),
            color: (appParamState.selectedBunrui == '$category2|${element.bunrui}')
                ? Colors.blueAccent.withOpacity(0.3)
                : null,
          ),
          child: GestureDetector(
            onTap: () {
              /// notifier 選択された分類をセット
              _ref.watch(appParamProvider.notifier).setSelectedBunrui(category2: category2, bunrui: element.bunrui);

              /// notifier 分類に紐づく動画を取得
              _ref.watch(videoListProvider.notifier).getVideoList(bunrui: element.bunrui);
            },
            child: Text(element.bunrui),
          ),
        ),
      );
    });

    return SizedBox(
      height: 40,
      child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: list)),
    );
  }

  ///
  Widget displayVideoList() {
    final list = <Widget>[];

    final appParamState = _ref.watch(appParamProvider);

    final videoListState = _ref.watch(videoListProvider);

    videoListState.forEach((element) {
      list.add(
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: (appParamState.youtubeIdList.contains(element.youtubeId))
                    ? Colors.blueAccent.withOpacity(0.2)
                    : Colors.transparent,
              ),

              ////

              child: VideoListItem(data: element, listAddDisplay: true, linkDisplay: true),

              ////
            ),
            const Divider(color: Colors.white),
          ],
        ),
      );
    });

    return SingleChildScrollView(key: PageStorageKey(uuid.v1()), child: Column(children: list));
  }

  ///
  Widget manipulateButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Row(
          children: [
            ChoiceChip(
              selected: true,
              label: const Text('選出', style: TextStyle(fontSize: 12)),
              selectedColor: Colors.blueAccent.withOpacity(0.3),
              onSelected: (bool isSelected) async {
                /// notifier 選択された動画を選出する
                await _ref.watch(videoManipulateProvider.notifier).videoManipulate(flag: 'special');

                await videoListReload();
              },
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              selected: true,
              label: const Text('分類消去', style: TextStyle(fontSize: 12)),
              selectedColor: Colors.blueAccent.withOpacity(0.3),
              onSelected: (bool isSelected) async {
                /// notifier 選択された動画の分類を消去する
                await _ref.watch(videoManipulateProvider.notifier).videoManipulate(flag: 'erase');

                await videoListReload();
              },
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              selected: true,
              label: const Text('削除', style: TextStyle(fontSize: 12)),
              selectedColor: Colors.blueAccent.withOpacity(0.3),
              onSelected: (bool isSelected) async {
                /// notifier 選択された動画を削除する
                await _ref.watch(videoManipulateProvider.notifier).videoManipulate(flag: 'delete');

                await videoListReload();
              },
            ),
          ],
        ),
      ],
    );
  }

  ///
  Future<void> videoListReload() async {
    final appParamState = _ref.watch(appParamProvider);

    /// notifier 動画の選択をクリアする
    await _ref.watch(appParamProvider.notifier).clearYoutubeIdList();

    /// notifier 選択された分類の動画を取得する
    await _ref.watch(videoListProvider.notifier).getVideoList(bunrui: appParamState.selectedBunrui.split('|')[1]);
  }
}
