import 'dart:convert';

class RecentFeedsModel {
  final String title;
  final String competition;
  final String matchviewUrl;
  final String competitionUrl;
  final String thumbnail;
  final DateTime date;
  final List<RecentFeedsVideosModel> videos;

  RecentFeedsModel({required this.title, required this.competition, required this.matchviewUrl, required this.competitionUrl, required this.thumbnail, required this.date, required this.videos});

  factory RecentFeedsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> videosList = json['videos'];
    List<RecentFeedsVideosModel> recentFeedsVideos = videosList.map((e) => RecentFeedsVideosModel.fromJson(e)).toList();
    return RecentFeedsModel(
      title: json['title'],
      competition: json['competition'],
      competitionUrl: json['competitionUrl'],
      date: DateTime.parse(json['date']),
      matchviewUrl: json['matchviewUrl'],
      thumbnail: json['thumbnail'],
      videos: recentFeedsVideos,
    );
  }

  String toJson() {
    return jsonEncode({
      title: title,
      competition: competition,
      competitionUrl: competitionUrl,
      date: date.toString(),
      matchviewUrl: matchviewUrl,
      thumbnail: thumbnail,
      videos: videos.toString(),
    });
  }
}


class RecentFeedsVideosModel {
  final String id;
  final String title;
  final String embed;

  RecentFeedsVideosModel({required this.id, required this.title, required this.embed});

  factory RecentFeedsVideosModel.fromJson(Map<String, dynamic> json) {
    return RecentFeedsVideosModel(
      embed: json['embed'],
      id: json['id'],
      title: json['title'],
    );
  }

  @override
   toString() {
    return jsonEncode({
      embed: embed,
      id: id,
      title: title,
    });
  }
}
