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
    );
  }
}
