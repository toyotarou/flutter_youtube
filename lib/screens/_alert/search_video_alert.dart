// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube3/screens/_alert/bunrui_input_alert.dart';
import 'package:youtube3/screens/_parts/bunrui_dialog.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';
import '../../viewmodel/video_notifier.dart';
import '../_parts/video_list_item.dart';

class SearchVideoAlert extends ConsumerWidget {
  SearchVideoAlert({super.key});

  final Utility _utility = Utility();

  TextEditingController searchText = TextEditingController();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final deviceInfoState = ref.read(deviceInfoProvider);

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
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchText,
                      decoration: const InputDecoration(labelText: 'word'),
                    ),
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.withOpacity(0.3),
                          ),
                          onPressed: () {
                            ref
                                .watch(appParamProvider.notifier)
                                .setSearchText(text: searchText.text);
                          },
                          child: const Text(
                            '検索する',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(child: displaySearchedVideo()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySearchedVideo() {
    final list = <Widget>[];

    final appParamState = _ref.watch(appParamProvider);

    if (appParamState.searchText != '') {
      final bunruiMapState = _ref.watch(bunruiMapProvider);

      final reg = RegExp(appParamState.searchText);

      final videoHistoryState = _ref.watch(videoHistoryProvider);
      videoHistoryState.forEach((element) {
        final category1 =
            bunruiMapState[element.bunrui.toString()]?['category1'];
        final category2 =
            bunruiMapState[element.bunrui.toString()]?['category2'];

        final match = reg.firstMatch(element.title);
        final match2 = reg.firstMatch(element.channelTitle);

        if (match != null || match2 != null) {
          list.add(
            Column(
              children: [
                VideoListItem(
                  data: element,
                  listAddDisplay: false,
                  linkDisplay: true,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(category1 ?? ''),
                                Text(category2 ?? ''),
                                Text(
                                  (element.bunrui == 0)
                                      ? '---'
                                      : element.bunrui.toString(),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BunruiDialog(
                                context: _context,
                                widget: BunruiInputAlert(video: element),
                              );
                            },
                            child: Icon(
                              Icons.input,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white),
              ],
            ),
          );
        }
      });
    }

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
