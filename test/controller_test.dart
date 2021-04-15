import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:journey_tracker/controller/controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final Controller controller = Get.put(Controller.empty(), permanent: true);

  group('App unit tests', () {
    test('Test initial variable values', () {
      expect(controller.selectedChapterChallenges, []);
      expect(controller.toggledChapterChallenges, []);
      expect(controller.amountChecked, 0);
      expect(controller.amountCheckedPercentage, 0.0);
      expect(controller.amountCheckedLabel, "0.0%");
      expect(controller.maxChallengesAmount, 0);
    });

    test('Test initialized variable values', () async {
      await controller.initTestData();
      expect(controller.selectedChapterChallenges, []);
      expect(controller.toggledChapterChallenges, []);
      expect(controller.amountChecked, 0);
      expect(controller.amountCheckedPercentage, 0.0);
      expect(controller.amountCheckedLabel, "0.0%");
      expect(controller.maxChallengesAmount, 94);
      expect(controller.title, 'Season 22');
    });
  });
}
