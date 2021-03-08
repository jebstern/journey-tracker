class Tier {
  int id;
  String title;
  String reward;

  Tier({
    this.title,
    this.reward,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'reward': reward,
    };
    return map;
  }

  Tier.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    reward = map['reward'];
  }
}
