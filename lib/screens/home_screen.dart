// ignore_for_file: must_be_immutable, use_decorated_box, cascade_invocations, empty_catches

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/device_info/device_info_notifier.dart';
import '../state/device_info/device_info_request_state.dart';
import '../viewmodel/category_notifier.dart';
import '_alert/bunrui_blank_video_alert.dart';
import '_alert/history_video_alert.dart';
import '_alert/search_video_alert.dart';
import '_alert/special_video_alert.dart';
import '_pages/category_list_page.dart';
import '_parts/bunrui_dialog.dart';
import 'calendar_get_screen.dart';
import 'calendar_publish_screen.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  List<TabInfo> tabs = [];

  List<DragAndDropItem> ddItem = [];

  int selectedIndex = 0;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  List<DragAndDropList> contents = [];

  late WidgetRef _ref;

  //---------------------------------------------------//

  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {}
  }

  ///
  void _readAndroidBuildData(AndroidDeviceInfo build) {
    final request = DeviceInfoRequestState(name: build.brand, systemName: build.product, model: build.model);

    /// notifier Androidのデバイス情報をセット
    _ref.watch(deviceInfoProvider.notifier).setDeviceInfo(param: request);
  }

  ///
  void _readIosDeviceInfo(IosDeviceInfo data) {
    final request =
        DeviceInfoRequestState(name: data.name ?? '', systemName: data.systemName ?? '', model: data.model ?? '');

    /// notifier iosのデバイス情報をセット
    _ref.watch(deviceInfoProvider.notifier).setDeviceInfo(param: request);
  }

  //---------------------------------------------------//

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeBigCategoryTab();

    initPlatformState();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        //

        appBar: AppBar(
          elevation: 0,
          title: const Text('Video Category'),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => BunruiDialog(context: context, widget: BunruiBlankVideoAlert()),
            child: const Icon(Icons.input),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarGetScreen()),
                      );
                    },
                    child: const SizedBox(
                      width: 60,
                      child: Column(children: [Icon(Icons.calendar_today_sharp), Text('Get')]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarPublishScreen()),
                      );
                    },
                    child: const SizedBox(
                      width: 60,
                      child: Column(children: [Icon(Icons.calendar_today_sharp), Text('Publish')]),
                    ),
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
                ),
              ),
              Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.5))),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.blueAccent,
            tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
          ),
        ),

        //

        body: TabBarView(children: tabs.map((tab) => tab.widget).toList()),

        //

        floatingActionButton: FabCircularMenuPlus(
          ringColor: Colors.blueAccent.withOpacity(0.3),
          fabOpenColor: Colors.blueAccent.withOpacity(0.3),
          fabCloseColor: Colors.blueAccent.withOpacity(0.3),
          ringWidth: 10,
          ringDiameter: 250,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.recycling, color: Colors.purpleAccent),
              onPressed: () {},
              // onPressed: () {
              //   Navigator.pushNamed(context, '/recycle');
              // },
            ),
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () => BunruiDialog(context: context, widget: SpecialVideoAlert()),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () => BunruiDialog(context: context, widget: HistoryVideoAlert()),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => BunruiDialog(context: context, widget: SearchVideoAlert()),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.yellowAccent),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ///
  void makeBigCategoryTab() {
    final bigCategoryState = _ref.watch(bigCategoryProvider);

    for (var i = 0; i < bigCategoryState.length; i++) {
      if (bigCategoryState[i].category1 != '') {
        if (bigCategoryState[i].category1 != 'null') {
          tabs.add(TabInfo(
            bigCategoryState[i].category1,
            CategoryListPage(category1: bigCategoryState[i].category1),
          ));
        }
      }
    }
  }
}
