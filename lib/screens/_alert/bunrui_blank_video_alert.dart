// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube3/screens/_alert/bunrui_input_alert.dart';
import 'package:youtube3/screens/_parts/bunrui_dialog.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/video_notifier.dart';
import '../_parts/video_list_item.dart';

class BunruiBlankVideoAlert extends ConsumerWidget {
  BunruiBlankVideoAlert({super.key});

  final Utility _utility = Utility();

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

              const SizedBox(height: 20),
              Expanded(child: displayBlankBunruiVideo()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBlankBunruiVideo() {
    final list = <Widget>[];

    final blankBunruiVideoState = _ref.watch(blankBunruiVideoProvider);

    blankBunruiVideoState.forEach((element) {
      list.add(
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.yellowAccent.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: () {
                      BunruiDialog(
                        context: _context,
                        widget: BunruiInputAlert(video: element),
                      );
                    },
                    child: const Icon(Icons.input),
                  ),
                ],
              ),
            ),
            VideoListItem(
              data: element,
              listAddDisplay: false,
              linkDisplay: false,
            ),
            const Divider(color: Colors.white),
          ],
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
