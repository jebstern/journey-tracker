class Chapter {
  Chapter({
    this.title,
    this.challenges,
    this.reward,
  });

  String title;
  List<String> challenges;
  String reward;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        title: json["title"],
        challenges: List<String>.from(json["challenges"].map((x) => x)),
        reward: json["reward"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "challenges": List<dynamic>.from(challenges.map((x) => x)),
        "reward": reward,
      };
}
