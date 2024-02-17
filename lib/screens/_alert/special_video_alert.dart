// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/video_notifier.dart';
import '../_parts/video_list_item.dart';

class SpecialVideoAlert extends ConsumerWidget {
  SpecialVideoAlert({super.key});

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

              const SizedBox(height: 10),
              Expanded(child: displayOrderedSpecialVideoList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayOrderedSpecialVideoList() {
    final list = <Widget>[];

    final specialVideoState = _ref.watch(specialVideoProvider);

    specialVideoState.forEach((element) {
      list.add(ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              element.bunrui,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              element.count.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        children: element.item.map((val) {
          return VideoListItem(
            data: val,
            listAddDisplay: false,
            linkDisplay: true,
          );
        }).toList(),
      ));
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}
