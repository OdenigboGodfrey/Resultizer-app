class FixtureTeam {
  final int id;
  final String goals;
  String? logo;
  String? name;
  bool? winner;

  FixtureTeam({
    required this.id,
    required this.goals,
    this.logo,
    this.name,
    this.winner,
  });

  factory FixtureTeam.fromJson(Map<String, dynamic> json) {
    return FixtureTeam(
      id: json['id'],
      goals: json['goals'],
      logo: json['logo'],
      name: json['name'],
      winner: json['winner'],
    );
  }
}

