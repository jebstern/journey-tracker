import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:journey_tracker/model/challenge_model.dart';
import 'package:journey_tracker/model/season_journey_model.dart';
import 'package:journey_tracker/repository/db_provider.dart';

class Controller extends GetxController {
  static Controller get to => Get.find();
  SeasonJourney seasonJourney;
  Chapter chapter;
  DBProvider dbProvider;
  List<Challenge> selectedChapterChallenges = [];
  List<Challenge> savedChapterChallenges = [];
  int amountChecked = 0;
  double amountCheckedPercentage = 0.0;
  String amountCheckedLabel = "0.0%";
  int maxChallengesAmount = 0;
  String title;

  Controller() {
    _init();
  }

  Controller.empty();

  Future<void> _init() async {
    print("Controller - _init() called!");
    dbProvider = DBProvider();
    String jsonString = await rootBundle.loadString("assets/seasonJourney.json");
    seasonJourney = SeasonJourney.fromJson(json.decode(jsonString));
    title = seasonJourney.title;
    await dbProvider.initDb(seasonJourney.title ?? "unknownSeason");
    seasonJourney.chapters.forEach((Chapter chapter) async {
      maxChallengesAmount += chapter.challenges.length;
      chapter.amountCompletedChallenges = await dbProvider.completedChallengesInChapter(chapter.title);
    });
    await _setCheckedValues();
  }

  Future<void> initTestData() async {
    seasonJourney = SeasonJourney.fromJson(json.decode(await rootBundle.loadString("assets/seasonJourney.json")));
    title = seasonJourney.title;
    seasonJourney.chapters.forEach((Chapter chapter) {
      maxChallengesAmount += chapter.challenges.length;
    });
    update();
  }

  Future<void> setChapter(String chapterTitle) async {
    savedChapterChallenges.clear();
    savedChapterChallenges = await dbProvider.getChallengesFromChapter(chapterTitle);
    chapter = seasonJourney.chapters.firstWhere((Chapter chapter) => chapter.title == chapterTitle, orElse: () => null);
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
    chapter.amountCompletedChallenges = chapter.amountCompletedChallenges + (selectedChapterChallenges[index].isCompleted == true ? 1 : -1);
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
