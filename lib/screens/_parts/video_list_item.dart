// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/video.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../viewmodel/category_notifier.dart';

class VideoListItem extends ConsumerWidget {
  VideoListItem({super.key, required this.data, required this.listAddDisplay, required this.linkDisplay});

  final Video data;
  final bool listAddDisplay;
  final bool linkDisplay;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    var getdate = '';

    if (data.getdate != 'null') {
      final year = data.getdate.substring(0, 4);
      final month = data.getdate.substring(4, 6);
      final day = data.getdate.substring(6);
      getdate = '$year-$month-$day';
    }

    return Stack(
      children: [
        Positioned(
          right: -60,
          top: -60,
          child: Container(
            padding: const EdgeInsets.all(60),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 10, color: Colors.blueAccent.withOpacity(0.3)),
              color: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          left: -80,
          bottom: -80,
          child: Container(
            padding: const EdgeInsets.all(60),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 10, color: Colors.blueAccent.withOpacity(0.3)),
              color: Colors.transparent,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //

                SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/no_image.png',
                          image: 'https://img.youtube.com/vi/${data.youtubeId}/mqdefault.jpg',
                          imageErrorBuilder: (c, o, s) => Image.asset('assets/images/no_image.png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            (data.special == '1')
                                ? const Icon(Icons.star, color: Colors.greenAccent)
                                : Icon(Icons.star, color: Colors.grey.withOpacity(0.3)),
                            const SizedBox(height: 10),
                            if (listAddDisplay) ...[
                              GestureDetector(
                                onTap: () =>
                                    _ref.watch(appParamProvider.notifier).setYoutubeIdList(youtubeId: data.youtubeId),
                                child: const Icon(Icons.control_point),
                              ),
                              const SizedBox(width: 20),
                            ],
                            const SizedBox(height: 10),
                            if (linkDisplay)
                              GestureDetector(
                                onTap: () => _openBrowser(youtubeId: data.youtubeId),
                                child: const Icon(Icons.link),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                //

                Text(data.title),
                const SizedBox(height: 5),

                //

                Text.rich(
                  TextSpan(children: [
                    TextSpan(text: data.youtubeId),
                    if (data.playtime != 'null') ...[
                      const TextSpan(text: ' / '),
                      TextSpan(text: data.playtime, style: const TextStyle(color: Colors.yellowAccent)),
                    ],
                  ]),
                ),

                //

                if (data.channelTitle != 'null') ...[
                  const SizedBox(height: 5),
                  Container(alignment: Alignment.topRight, child: Text(data.channelTitle)),
                ],

                //

                if (getdate != '') ...[
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(text: getdate),
                        const TextSpan(text: ' / '),
                        TextSpan(text: data.pubdate, style: const TextStyle(color: Colors.yellowAccent)),
                      ]),
                    ),
                  ),

                  //
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  Future<void> _openBrowser({required String youtubeId}) async {
    /// notifier 最終呼び出し日時を記録
    await _ref.watch(playedAtUpdateProvider.notifier).updateVideoPlayedAt(youtubeId: youtubeId);

    final url = Uri.parse('https://youtu.be/$youtubeId');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
