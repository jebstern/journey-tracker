import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey_tracker/controller/controller.dart';
import 'package:journey_tracker/pages/chapter_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller c = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season 22'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GetBuilder<Controller>(
          builder: (controller) => Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  animationDuration: 1000,
                  percent: c.amountCheckedPercentage,
                  center: Text(
                    c.amountCheckedLabel,
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                  header: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      "Total completion: ${controller.amountChecked}/85",
                      style: const TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
      drawer: GetBuilder<Controller>(
        builder: (controller) => Drawer(
          child: Builder(
            builder: (context) => ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: ScrollPhysics(parent: PageScrollPhysics()),
              children: _getDrawerItems(controller),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getDrawerItems(Controller controller) {
    List<Widget> items = [];

    items.add(
      UserAccountsDrawerHeader(
        accountName: Text("D3 Seasonal Journey tracker"),
        accountEmail: Text("Total completion: ${c.amountChecked}/85"),
        currentAccountPicture: CircleAvatar(
          backgroundImage: AssetImage("assets/logo.png"),
        ),
      ),
    );

    for (int i = 0; i < controller.chapters.length; i++) {
      items.add(ListTile(
        title: Text(controller.chapters[i].title),
        onTap: () {
          Get.back();
          Get.to(
            () => ChapterWidget(
              chapter: controller.chapters[i].title,
            ),
          );
        },
      ));
    }

    return items;
  }
}
