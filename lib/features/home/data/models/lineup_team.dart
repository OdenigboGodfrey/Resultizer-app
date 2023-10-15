
import 'package:resultizer_merged/features/home/data/models/fixture_teams_dto.dart';

class LineupTeam extends FixtureTeam {
  final LineupColors colors;

  LineupTeam(
      {required int id,
      required String name,
      required String logo,
      required this.colors})
      : super(id: id, name: name, logo: logo);

  factory LineupTeam.fromJson(Map<String, dynamic> json) {
    try {
      return LineupTeam(id: json['id'], name: json['name'], logo: json['logo'], colors: LineupColors.fromJson(json['colors']));
    }
    catch(err, stackTrace) {
      print('err $err');
      print('stackTrace $stackTrace');
      return LineupTeam(id: json['id'], name: json['name'], logo: json['logo'], colors: LineupColors.fromJson(json['colors']));
    }
  }
}

class PlayerColors {
  final String primary;
  final String number;
  final String border;

  const PlayerColors(
      {required this.primary, required this.number, required this.border});
  
  factory PlayerColors.fromJson(Map<String, dynamic> json) {
    return PlayerColors(primary: json['primary'], number: json['number'], border: json['border']);
  }
}

class LineupColors {
  final PlayerColors player;
  final PlayerColors goalKeeper;

  const LineupColors({required this.player, required this.goalKeeper});

  factory LineupColors.fromJson(Map<String, dynamic> json) {
    return LineupColors(player: PlayerColors.fromJson(json['player']), goalKeeper: PlayerColors.fromJson(json['goalkeeper']));
  }
}
