// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/video.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';
import '../_parts/bunrui_dialog.dart';
import '../_parts/video_list_item.dart';
import 'bunrui_input_alert.dart';

class CalendarVideoAlert extends ConsumerWidget {
  CalendarVideoAlert(
      {super.key,
      required this.thisDateData,
      required this.date,
      required this.pubget});

  final List<Video> thisDateData;
  final String date;
  final String pubget;

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
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text('$pubget $date'),
              ],
            ),
            Divider(
              color: Colors.white.withOpacity(0.3),
              thickness: 2,
            ),
            Expanded(child: displayDateData()),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayDateData() {
    final list = <Widget>[];

    final bunruiMapState = _ref.watch(bunruiMapProvider);

    thisDateData.forEach((element) {
      final category1 = bunruiMapState[element.bunrui.toString()]?['category1'];
      final category2 = bunruiMapState[element.bunrui.toString()]?['category2'];

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
              child: Row(
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: const TextStyle(fontSize: 12),
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
                  ),
                  IconButton(
                    onPressed: () {
                      BunruiDialog(
                        context: _context,
                        widget: BunruiInputAlert(video: element),
                      );
                    },
                    icon: Icon(
                      Icons.info,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
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
