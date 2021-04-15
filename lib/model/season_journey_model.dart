class SeasonJourneyModel {
  SeasonJourneyModel({
    this.title = "",
    this.chapters = const [],
  });

  late String title;
  late List<Chapter> chapters;

  factory SeasonJourneyModel.fromJson(Map<String, dynamic> json) => SeasonJourneyModel(
        title: json["title"] ?? "",
        chapters: List<Chapter>.from(
          json["chapters"].map((x) => Chapter.fromJson(x)) ?? [],
        ),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "chapters": List<dynamic>.from(
          chapters.map((x) => x.toJson()),
        ),
      };
}

class Chapter {
  Chapter({
    this.title = "",
    this.challenges = const [],
    this.reward = "",
  });

  String title;
  List<String> challenges;
  String reward;
  int amountCompletedChallenges = 0;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        title: json["title"] ?? "",
        challenges: List<String>.from(
          json["challenges"].map((x) => x) ?? [],
        ),
        reward: json["reward"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "challenges": List<dynamic>.from(
          challenges.map((x) => x),
        ),
        "reward": reward,
      };
}
