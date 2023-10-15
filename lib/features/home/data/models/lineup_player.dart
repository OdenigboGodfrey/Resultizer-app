class LineUpPlayer {
  final int id;
  final String name;
  final int number;
  final String pos;
  final String grid;

  const LineUpPlayer({
    required this.id,
    required this.name,
    required this.number,
    required this.grid,
    required this.pos,
  });

  factory LineUpPlayer.fromJson(Map<String, dynamic> json) {
    dynamic player = json['player'];
    return LineUpPlayer(
        id: player['id'],
        name: player['name'],
        number: player['number'],
        grid: player['grid']!=null ? player['grid'].toString() : '',
        pos: player['pos']);
  }
}
