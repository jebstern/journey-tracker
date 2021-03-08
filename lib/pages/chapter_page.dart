import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey_tracker/controller/controller.dart';
import 'package:journey_tracker/model/challenge_model.dart';
import 'package:journey_tracker/widgets/challenge_widget.dart';

class ChapterWidget extends StatefulWidget {
  final String chapter;

  ChapterWidget({Key key, @required this.chapter}) : super(key: key);

  @override
  ChapterWidgetState createState() => ChapterWidgetState();
}

class ChapterWidgetState extends State<ChapterWidget> {
  final Controller c = Get.find<Controller>();
  List<ChallengeWidget> challengesList2 = [];
  bool groupValue = false;

  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
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
                    controller.chapter == null ? "" : controller.chapter.reward,
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
    if (controller.selectedChapterChallenges == null) {
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
