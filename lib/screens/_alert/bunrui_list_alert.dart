// ignore_for_file: must_be_immutable, cascade_invocations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/setting_category/setting_category_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';

class BunruiListAlert extends ConsumerWidget {
  BunruiListAlert({super.key, required this.tecs});

  final List<TextEditingController> tecs;

  final Utility _utility = Utility();

  List<String> bunruiList = [];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeBunruiList();

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 50,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              children: [
                Container(width: context.screenSize.width),

                //----------//
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                displayBunruiList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBunruiList() {
    final bunruiMapState = _ref.watch(bunruiMapProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bunruiList.map(
        (value) {
          if (value == '') {
            return Container();
          }

          final category1 = bunruiMapState[value]?['category1'];
          final category2 = bunruiMapState[value]?['category2'];

          return Slidable(
            startActionPane: ActionPane(
              extentRatio: 1,
              motion: const ScrollMotion(), // (5)
              children: [
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Colors.blueAccent.withOpacity(0.3),
                  foregroundColor: Colors.white,
                  label: category1,
                  icon: Icons.list,
                ),
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Colors.blueAccent.withOpacity(0.1),
                  foregroundColor: Colors.white,
                  label: category2,
                  icon: Icons.list,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              width: MediaQuery.of(_context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _ref
                          .watch(settingCategoryProvider.notifier)
                          .setInputedCategory1(
                            value: category1 ?? '',
                          );

                      await _ref
                          .watch(settingCategoryProvider.notifier)
                          .setInputedCategory2(
                            value: category2 ?? '',
                          );

                      tecs[0].text = category1 ?? '';
                      tecs[1].text = category2 ?? '';
                      tecs[2].text = value;
                      Navigator.pop(_context);
                    },
                    child: Icon(
                      Icons.input,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  ///
  void makeBunruiList() {
    bunruiList = [];

    final bigCategoryState = _ref.watch(bigCategoryProvider);

    final bl = <String>[];
    bigCategoryState.forEach((element) {
      final smallCategoryState =
          _ref.watch(smallCategoryProvider(element.category1));

      smallCategoryState.forEach((element2) {
        bl.add(element2.bunrui);
      });
    });

    bl.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    bl.forEach((element) {
      bunruiList.add(element);
    });
  }
}
