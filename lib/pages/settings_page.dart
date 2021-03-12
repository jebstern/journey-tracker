import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey_tracker/controller/controller.dart';

class SettingsPage extends StatelessWidget {
  final Controller c = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text("Clear completed challenges"),
            subtitle: Text("This action can't be undone!"),
            onTap: () async {
              await c.clearCompletedChallenges();
              Get.dialog(
                AlertDialog(
                  title: Text("Challenges cleared"),
                  content: Text("All completed challenges cleared."),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
