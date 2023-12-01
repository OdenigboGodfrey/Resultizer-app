
import 'package:resultizer_merged/features/home/data/models/fixture_teams_dto.dart';

class StatisticsModel {
  final FixtureTeam team;
  final List<StatisticItemModel> statistics;

  const StatisticsModel({required this.team, required this.statistics});

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    print('json ${json}');
    List<dynamic> statisticsList = [];
    List<StatisticItemModel> statistics = [];
    
    if (json.containsKey('statistics')) {
      statisticsList = json['statistics'];
      statistics = statisticsList.map((e) => StatisticItemModel.fromJson(e)).toList();
    }
    
    return StatisticsModel(
      team: FixtureTeam.fromJson(json['team']),
      statistics: statistics,
    );
  }
}

class StatisticItemModel {
  final String type;
  final String value;

  const StatisticItemModel({required this.type, required this.value});

  factory StatisticItemModel.fromJson(Map<String, dynamic> json) {
    try {
      return StatisticItemModel(
        type: json['type'] !=  null ? json['type'].toString() : '',
        value: json['value'] != null ? json['value'].toString() : '',
      );
    }
    catch(error, stackTrace) {
      print('error ${error} ---------- stackTrace ${stackTrace}');
      return const StatisticItemModel(
        type: 'err',
        value: 'err',
      );
    }
    
  }

  
}
