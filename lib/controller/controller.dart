import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:journey_tracker/model/challenge_model.dart';
import 'package:journey_tracker/repository/db_provider.dart';
import 'package:journey_tracker/model/chapter_model.dart';

class Controller extends GetxController {
  static Controller get to => Get.find();
  List<Chapter> chapters;
  Chapter chapter;
  DBProvider dbProvider;
  List<Challenge> selectedChapterChallenges = [];
  List<Challenge> savedChapterChallenges = [];
  int amountChecked = 0;
  double amountCheckedPercentage = 0.0;
  String amountCheckedLabel = "0.0%";
  int maxChallengesAmount = 85;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  Future<void> _init() async {
    dbProvider = DBProvider();
    await dbProvider.initDb();
    chapters = List<Chapter>.from(json.decode(await rootBundle.loadString("assets/challenges.json")).map((x) => Chapter.fromJson(x)));
    await _setCheckedValues();
  }

  Future<void> setChapter(String chapterTitle) async {
    savedChapterChallenges.clear();
    savedChapterChallenges = await dbProvider.getChallengesFromChapter(chapterTitle);
    chapter = chapters.firstWhere((Chapter chapter) => chapter.title == chapterTitle, orElse: () => null);
    selectedChapterChallenges.clear();
    chapter.challenges.forEach((String challengeTitle) {
      Challenge challenge = savedChapterChallenges.firstWhere((Challenge cha) => cha.title == challengeTitle, orElse: () => null);
      selectedChapterChallenges.add(challenge == null ? Challenge(chapter: chapter.title, title: challengeTitle, isCompleted: false) : challenge);
    });
    update();
  }

  Future<void> toggleCompleted(Challenge updatedChallenge) async {
    int index = selectedChapterChallenges.indexOf(updatedChallenge);
    selectedChapterChallenges[index].isCompleted = !selectedChapterChallenges[index].isCompleted;
    await dbProvider.toggleCompleted(selectedChapterChallenges[index]);
    await _setCheckedValues();
  }

  Future<void> _setCheckedValues() async {
    amountChecked = await dbProvider.getAllChecked();
    amountCheckedLabel = (amountChecked / maxChallengesAmount * 100).toStringAsFixed(1) + " %";
    amountCheckedPercentage = double.parse((amountChecked / maxChallengesAmount).toStringAsFixed(1));
    update();
  }

  Future<void> clearCompletedChallenges() async {
    await dbProvider.clearCompletedChallenges();
    await _setCheckedValues();
  }
}
