class Challenge {
  int id;
  String title;
  String chapter;
  bool isCompleted;

  Challenge({
    this.title,
    this.chapter,
    this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'tier': chapter,
    };
    return map;
  }

  Challenge.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    chapter = map['tier'];
    isCompleted = map['isCompleted'] == 1;
  }
}
