import 'package:resultizer_merged/features/home/data/models/lineup_player.dart';
import 'package:resultizer_merged/features/home/data/models/lineup_team.dart';

class Lineup {
  final LineupTeam team;
  final String coachName;
  final String formation;
  final List<LineUpPlayer> startXI;
  final List<LineUpPlayer> substitutes;

  const Lineup({
    required this.team,
    required this.coachName,
    required this.formation,
    required this.startXI,
    required this.substitutes,
  });

  factory Lineup.fromJson(Map<String, dynamic> json) {
    List<dynamic> startXIList  = [];
    List<LineUpPlayer> startXI = [];
    if (json.containsKey('startXI')) {
      startXIList = json['startXI'];
      startXI = startXIList.map((e) => LineUpPlayer.fromJson(e)).toList();
    }

    List<dynamic> substitutesList  = [];
    List<LineUpPlayer> substitutes = [];
    if (json.containsKey('substitutes')) {
      substitutesList = json['substitutes'];
      substitutes = substitutesList.map((e) => LineUpPlayer.fromJson(e)).toList();
    }
    
    return Lineup(
        coachName: json['coach']['name'] ?? '',
        formation: json['formation'] ?? '',
        startXI: startXI,
        substitutes: substitutes,
        team: LineupTeam.fromJson(json['team']));
  }
}
