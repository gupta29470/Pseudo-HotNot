class VideoFeedModel {
/*
{
  "videos": [
    "https://customer-2p3jflss4r4hmpnz.cloudflarestream.com/01227cb1645d4ace8707f475c95e8207/downloads/default.mp4"
  ]
} 
*/

  List<String?>? videos;

  VideoFeedModel({
    this.videos,
  });
  VideoFeedModel.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      final v = json['videos'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      videos = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (videos != null) {
      final v = videos;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['videos'] = arr0;
    }
    return data;
  }
}
