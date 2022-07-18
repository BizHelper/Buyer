import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('testing', () {
    final enterEmail = find.byValueKey("enterEmail");
    final enterPassword = find.byValueKey("enterPassword");
    final signInButton = find.byValueKey("signin");
    final requestPage = find.byValueKey("requestPage");
    final addNewRequestButton = find.byValueKey("addNewRequest");
    //final addNewRequestButton = find.byKey(ValueKey("addNewRequest"));
    final addTitle = find.byValueKey("addTitle");
    final addPrice = find.byValueKey("addPrice");
    final addCategory = find.byValueKey("addCategory");
    final addDescription = find.byValueKey("addDescription");
    final addDeadline = find.byValueKey("addDeadline");
    final addButton = find.byValueKey("addButton");
    late FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test("login", () async{
      await driver.tap(enterEmail);
      await driver.enterText("hioksurebye@gmail.com");
      await driver.tap(enterPassword);
      await driver.enterText("bizhelper00");
      await driver.tap(signInButton);
      await driver.waitFor(find.text("Home"));
    });


   test("Request", () async{
      await driver.tap(requestPage);
      await driver.tap(addNewRequestButton);
      await driver.tap(addTitle);
      await driver.enterText("Custom-made leather wallet");
      await driver.tap(addPrice);
      await driver.enterText("22");
      await driver.tap(addCategory);
      await driver.tap(find.text('Bags & Wallets'));
      await driver.tap(addDescription);
      await driver.enterText(
          "Looking for a brown wallet made out of lamb leather");
      await driver.tap(addDeadline);
      await driver.tap(find.text("27"));
      await driver.tap(find.text("OK"));
      await driver.tap(addButton);
      //await driver.tap(find.pageBack());
    });
    tearDownAll(() async {
      if(driver!=null){
        driver.close();
      }
    });
  });
}