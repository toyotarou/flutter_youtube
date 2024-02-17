// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/video_notifier.dart';
import '../_parts/video_list_item.dart';

class HistoryVideoAlert extends ConsumerWidget {
  HistoryVideoAlert({super.key});

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final deviceInfoState = ref.read(deviceInfoProvider);

    final maxYear = DateTime.now().yyyy;

    final appParamState = ref.watch(appParamProvider);

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

              Slider(
                value: (appParamState.selectedYear == '')
                    ? double.parse(maxYear)
                    : double.parse(appParamState.selectedYear),
                min: 2019,
                max: double.parse(maxYear),
                onChanged: (double value) {
                  /// notifier 選択された年をセット
                  ref
                      .watch(appParamProvider.notifier)
                      .setSelectedYear(year: value.toString().split('.')[0]);
                },
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(appParamState.selectedYear),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(child: displayHistoryVideo()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayHistoryVideo() {
    final list = <Widget>[];

    final appParamState = _ref.watch(appParamProvider);

    final videoHistoryState = _ref.watch(videoHistoryProvider);

    videoHistoryState.forEach((element) {
      if (element.getdate.substring(0, 4) == appParamState.selectedYear) {
        list.add(
          Column(
            children: [
              VideoListItem(
                data: element,
                listAddDisplay: false,
                linkDisplay: true,
              ),
              const Divider(color: Colors.white),
            ],
          ),
        );
      }
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
