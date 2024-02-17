enum APIPath {
  bunruiYoutubeData,
  updateVideoPlayedAt,
  updateYoutubeCategoryTree,
  oneBunruiInput,
  getYoutubeCategoryTree,
  getYoutubeList,
  getSpecialVideo,
  getDeletedVideo,
  getBlankBunruiVideo
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.bunruiYoutubeData:
        return 'bunruiYoutubeData';
      case APIPath.updateVideoPlayedAt:
        return 'updateVideoPlayedAt';
      case APIPath.updateYoutubeCategoryTree:
        return 'updateYoutubeCategoryTree';
      case APIPath.oneBunruiInput:
        return 'oneBunruiInput';

      case APIPath.getYoutubeCategoryTree:
        return 'getYoutubeCategoryTree';
      case APIPath.getYoutubeList:
        return 'getYoutubeList';

      case APIPath.getSpecialVideo:
        return 'getSpecialVideo';
      case APIPath.getDeletedVideo:
        return 'getDeletedVideo';
      case APIPath.getBlankBunruiVideo:
        return 'getBlankBunruiVideo';
    }
  }
}
