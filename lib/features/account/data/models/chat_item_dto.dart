class ChatMetaDTO {
  final String homeTeam;
  final String awayTeam;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final String leagueName;
  final DateTime matchTime;
  final int fixtureId;
  final String leagueLogo;
  final String leagueSubtitle;
  final int homeTeamId;
  final int awayTeamId;
  final int leagueId;

  ChatMetaDTO(  
      {required this.homeTeam,
      required this.awayTeam,
      required this.homeTeamLogo,
      required this.awayTeamLogo,
      required this.leagueName,
      required this.matchTime,
      required this.fixtureId,
      required this.leagueLogo,
      required this.leagueSubtitle,
      required this.homeTeamId, 
      required this.awayTeamId,
      required this.leagueId,
    });

  dynamic toMap() {
    return {
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'homeTeamLogo': homeTeamLogo,
      'awayTeamLogo': awayTeamLogo,
      'leagueName': leagueName,
      'matchTime': matchTime.toString(),
      'fixtureId': fixtureId,
      'leagueLogo': leagueLogo,
      'leagueSubtitle': leagueSubtitle,
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'leagueId': leagueId,
    };
  }

  factory ChatMetaDTO.fromJson(dynamic json) {
    return ChatMetaDTO(
      homeTeam: json['homeTeam'],
      awayTeam: json['awayTeam'],
      homeTeamLogo: json['homeTeamLogo'],
      awayTeamLogo: json['awayTeamLogo'],
      leagueName: json['leagueName'],
      matchTime: DateTime.parse(json['matchTime']),
      fixtureId: json['fixtureId'],
      leagueLogo: json['leagueLogo'] ?? '',
      leagueSubtitle: json['leagueSubtitle'] ?? '',
      awayTeamId: json['awayTeamId'] ?? 0,
      homeTeamId: json['homeTeamId'] ?? 0,
      leagueId: json['leagueId'] ?? 0,
    );
  }
}
