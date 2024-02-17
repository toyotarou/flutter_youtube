// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

import '../extensions/extensions.dart';
import 'video.dart';

class SpecialVideo {
  SpecialVideo({
    required this.bunrui,
    required this.count,
    required this.item,
  });

  factory SpecialVideo.fromJson(Map<String, dynamic> json) => SpecialVideo(
        bunrui: json['bunrui'].toString(),
        count: json['count'].toString().toInt(),
        item: List<Video>.from(
            json['item'].map((x) => Video.fromJson(x as Map<String, dynamic>))
                as Iterable<dynamic>),
      );

  String bunrui;
  int count;
  List<Video> item;

  Map<String, dynamic> toJson() => {
        'bunrui': bunrui,
        'count': count,
        'item': List<dynamic>.from(item.map((x) => x.toJson())),
      };
}
