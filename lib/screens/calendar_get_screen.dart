// ignore_for_file: must_be_immutable

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../extensions/extensions.dart';
import '../models/video.dart';
import '../state/device_info/device_info_notifier.dart';
import '../utility/utility.dart';
import '../viewmodel/video_notifier.dart';
import '_alert/calendar_video_alert.dart';
import '_parts/bunrui_dialog.dart';

class CalendarGetScreen extends ConsumerWidget {
  CalendarGetScreen({super.key});

  final Utility _utility = Utility();

  Map<DateTime, List<String>> eventsList = {};

  ///
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final focusDayState = ref.watch(focusDayProvider);

    final videoHistoryState = ref.watch(videoHistoryProvider);

    //--------------------------------------------- event
    var keepYmd = '';

    videoHistoryState.forEach((element) {
      final exGetDate = element.getdate.split(' ');
      if (exGetDate[0] != keepYmd) {
        eventsList[DateTime.parse(exGetDate[0])] = [];
      }
      eventsList[DateTime.parse(exGetDate[0])]?.add(exGetDate[0]);
      keepYmd = exGetDate[0];
    });

    final events = LinkedHashMap<DateTime, List<dynamic>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(eventsList);

    List<dynamic> getEventForDay(DateTime day) {
      return events[day] ?? [];
    }
    //--------------------------------------------- event

    final deviceInfoState = ref.read(deviceInfoProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),

          ///////////// calendar
          Column(
            children: [
              const SizedBox(height: 50),

              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              TableCalendar(
                eventLoader: getEventForDay,

                ///
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.transparent),
                  selectedDecoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),

                  ///
                  todayTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  selectedTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeStartTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeEndTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  disabledTextStyle: TextStyle(color: Colors.grey),
                  weekendTextStyle: TextStyle(color: Colors.white),

                  ///
                  markerDecoration: BoxDecoration(color: Colors.white),
                  rangeStartDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  rangeEndDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  holidayDecoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Color(0xFF9FA8DA),
                      ),
                    ),
                  ),
                ),

                ///
                headerStyle: const HeaderStyle(formatButtonVisible: false),
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030, 12, 31),

                focusedDay: focusDayState,

                ///
                selectedDayPredicate: (day) {
                  return isSameDay(ref.watch(blueBallProvider), day);
                },

                ///
                onDaySelected: (selectedDay, focusedDay) {
                  onDayPressed(date: selectedDay);
                },
              ),
            ],
          ),
          ///////////// calendar
        ],
      ),
    );
  }

  ///
  void onDayPressed({required DateTime date}) {
    /// notifier カレンダー選択
    _ref.watch(blueBallProvider.notifier).setDateTime(dateTime: date);
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);

    final videoHistoryState = _ref.watch(videoHistoryProvider);

    final thisDateData = <Video>[];
    videoHistoryState.forEach((element) {
      if (date.yyyymmdd.replaceAll('-', '') == element.getdate) {
        thisDateData.add(element);
      }
    });

    if (thisDateData.isEmpty) {
      final snackBar = SnackBar(
        content: const Text(
          'No Data.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent.withOpacity(0.3),
        duration: const Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
      return;
    }

    BunruiDialog(
      context: _context,
      widget: CalendarVideoAlert(
        thisDateData: thisDateData,
        date: date.yyyymmdd,
        pubget: 'get',
      ),
    );
  }
}

////////////////////////////////////////////////////////////
final focusDayProvider =
    StateNotifierProvider.autoDispose<FocusDayStateNotifier, DateTime>((ref) {
  return FocusDayStateNotifier();
});

class FocusDayStateNotifier extends StateNotifier<DateTime> {
  FocusDayStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}

////////////////////////////////////////////////////////////
final blueBallProvider =
    StateNotifierProvider.autoDispose<BlueBallStateNotifier, DateTime>((ref) {
  return BlueBallStateNotifier();
});

class BlueBallStateNotifier extends StateNotifier<DateTime> {
  BlueBallStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}
