// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/app_param/app_param_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/category_notifier.dart';
import '../../viewmodel/video_notifier.dart';
import '../_alert/video_list_alert.dart';
import '../_parts/bunrui_dialog.dart';

class CategoryListPage extends ConsumerWidget {
  CategoryListPage({super.key, required this.category1});

  final String category1;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          SingleChildScrollView(
            child: Column(
              children: [displaySmallCategory()],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displaySmallCategory() {
    final list = <Widget>[];

    final smallCategoryState = _ref.watch(smallCategoryProvider(category1));

    final firstBunrui = <String, String>{};

    final getCategory = <String>[];

    smallCategoryState.forEach((element) {
      if (!getCategory.contains(element.category2)) {
        firstBunrui[element.category2] = element.bunrui;

        list.add(
          Stack(
            children: [
              Positioned(
                right: -50,
                top: -40,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 5, color: Colors.blueAccent.withOpacity(0.5)),
                    color: Colors.transparent,
                  ),
                ),
              ),

              //

              Positioned(
                left: -50,
                bottom: -40,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 5, color: Colors.blueAccent.withOpacity(0.5)),
                    color: Colors.transparent,
                  ),
                ),
              ),

              //

              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element.category2, style: const TextStyle(fontSize: 12)),
                    GestureDetector(
                      onTap: () {
                        _ref.watch(appParamProvider.notifier).setSelectedBunrui(
                              category2: element.category2,
                              bunrui: firstBunrui[element.category2]!,
                            );

                        _ref.watch(videoListProvider.notifier).getVideoList(bunrui: firstBunrui[element.category2]!);

                        BunruiDialog(
                          context: _context,
                          widget: VideoListAlert(category2: element.category2),
                        );
                      },
                      child: Icon(Icons.link, color: Colors.white.withOpacity(0.8)),
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
        );
      }

      getCategory.add(element.category2);
    });

    list.add(const SizedBox(height: 120));

    return SingleChildScrollView(child: Column(children: list));
  }
}
