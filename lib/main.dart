import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey_tracker/controller/controller.dart';
import 'package:journey_tracker/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Controller c = Get.put(Controller(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'D3 Journey Tracker',
      home: GetBuilder<Controller>(
        init: Controller(),
        builder: (s) => HomePage(),
      ),
      theme: ThemeData(fontFamily: 'Montserrat'),
    );
  }
}
