import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey_tracker/controller/controller.dart';
import 'package:journey_tracker/model/challenge_model.dart';

class ChapterWidget extends StatefulWidget {
  final String chapter;

  ChapterWidget({Key key, @required this.chapter}) : super(key: key);

  @override
  ChapterWidgetState createState() => ChapterWidgetState();
}

class ChapterWidgetState extends State<ChapterWidget> {
  final Controller c = Get.find<Controller>();

  void initState() {
    super.initState();
    c.setChapter(widget.chapter);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.chapter),
        ),
        body: GetBuilder<Controller>(
          builder: (controller) => TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: _challengesWidget(controller),
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    controller.selectedChapter == null ? "" : controller.selectedChapter.reward,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              child: Text(
                'Challenges',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Rewards',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.redAccent,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }

  List<Widget> _challengesWidget(Controller controller) {
    // If no challenges yet exists for chapter OR current chapter is differnet than previously selected chapter
    if (controller.selectedChapterChallenges == null || (controller.selectedChapter != null && controller.selectedChapter.title != widget.chapter)) {
      return [];
    } else {
      return controller.selectedChapterChallenges.map((Challenge challenge) {
        return CheckboxListTile(
          title: Text(challenge.title),
          value: challenge.isCompleted,
          onChanged: (value) => c.toggleCompleted(challenge),
        );
      }).toList();
    }
  }
}
