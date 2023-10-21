import 'dart:convert';

class ScorebatVideoModel {
  final String title;
  final String competition;
  final String matchviewUrl;
  final String competitionUrl;
  final String thumbnail;
  final DateTime date;
  final List<ScorebatSingleVideoModel> videos;

  ScorebatVideoModel({required this.title, required this.competition, required this.matchviewUrl, required this.competitionUrl, required this.thumbnail, required this.date, required this.videos});

  factory ScorebatVideoModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> videosList = json['videos'];
    List<ScorebatSingleVideoModel> recentFeedsVideos = videosList.map((e) => ScorebatSingleVideoModel.fromJson(e)).toList();
    return ScorebatVideoModel(
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


class ScorebatSingleVideoModel {
  final String id;
  final String title;
  final String embed;

  ScorebatSingleVideoModel({required this.id, required this.title, required this.embed});

  factory ScorebatSingleVideoModel.fromJson(Map<String, dynamic> json) {
    return ScorebatSingleVideoModel(
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
