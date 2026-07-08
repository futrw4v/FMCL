// EasyTier对等节点类
class PlayerList {
  final String? ipv4;
  final String name;
  final String cost;
  final String latency;
  final String loss;
  final String rx;
  final String tx;
  final String tunnel;
  final String nat;
  final String version;
  final String id;
  final String? playerName;
  final String? playerVendor;
  final String? playerKind;

  PlayerList({
    this.ipv4,
    required this.name,
    required this.cost,
    required this.latency,
    required this.loss,
    required this.rx,
    required this.tx,
    required this.tunnel,
    required this.nat,
    required this.version,
    required this.id,
    this.playerName,
    this.playerVendor,
    this.playerKind,
  });
}
