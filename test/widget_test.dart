import 'package:buyer_app/src/screens/home.dart';
import 'package:buyer_app/src/screens/login.dart';
import 'package:buyer_app/src/screens/productdescriptionscreen.dart';
import 'package:buyer_app/src/screens/requestDescription.dart';
import 'package:buyer_app/src/screens/requestform.dart';
import 'package:buyer_app/src/widgets/singlerequest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'mock.dart';

void main() async {
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();
  final enterEmail = find.byKey(ValueKey("enterEmail"));
  final enterPassword = find.byKey(ValueKey("enterPassword"));
  final signInButton = find.byKey(ValueKey("signin"));
  final addTitle = find.byKey(ValueKey("addTitle"));
  final addPrice = find.byKey(ValueKey("addPrice"));
  final addCategory = find.byKey(ValueKey("addCategory"));
  final addDescription = find.byKey(ValueKey("addDescription"));
  final addDeadline = find.byKey(ValueKey("addDeadline"));
  final addButton = find.byKey(ValueKey("addButton"));

  testWidgets('Login', (WidgetTester tester) async {
    LoginScreen loginScreen = LoginScreen();
    await tester.pumpWidget(MaterialApp(home: loginScreen));
    await tester.enterText(enterEmail, "hioksurebye@gmail.com");
    await tester.enterText(enterPassword, "bizhelper00");
    await tester.tap(signInButton);
    await tester.pump();
    expect(find.text("hioksurebye@gmail.com"), findsOneWidget);
    expect(find.text("bizhelper00"), findsOneWidget);
    expect(find.text("Buyer Login"), findsOneWidget);
  });
  testWidgets('Request Form', (WidgetTester tester) async {
    RequestFormScreen requestFormScreen = RequestFormScreen();
    await tester.pumpWidget(MaterialApp(home: requestFormScreen));
    await tester.enterText(addTitle, "Black Wallet");
    await tester.enterText(addPrice, "15");
    expect(find.text("Black Wallet"), findsOneWidget);
    expect(find.text("15"), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(addCategory);
    await tester.tap(find.text('Bags & Wallets').first, warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.pump();
    await tester.enterText(
        addDescription, "Looking for a black customised crocodile wallet");
    expect(find.text("Looking for a black customised crocodile wallet"),
        findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(addDeadline, warnIfMissed: false);
    await tester.pump();
  });
  testWidgets('Single Request', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: SingleRequest(
      buyerID: 'buyer id',
      buyerName: 'buyer name',
      category: 'category',
      deadline: 'deadline',
      deleted: 'false',
      description: 'description',
      price: '1.00',
      requestID: 'request id',
      sellerName: 'null',
      title: 'title',
    )));
    expect(find.text('title'), findsOneWidget);
    expect(find.text('Price: \$1.00'), findsOneWidget);
    expect(find.text('Deadline: deadline'), findsOneWidget);
    expect(find.text('Find out more!'), findsOneWidget);
  });

  testWidgets('Request Description Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: RequestDescriptionScreen(
      buyerName: "buyerName",
      sellerName: "sellerName",
      category: "category",
      deadline: "1/1/2023",
      description: "description",
      price: "23.00",
      title: "title",
      requestID: "requestID",
      buyerID: "buyerID",
      deleted: 'false',
    )));
    expect(find.text('title'), findsOneWidget);
    expect(find.text('\$23.00'), findsOneWidget);
    expect(find.text('Deadline: 1/1/2023'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.text('Delete Request'), findsOneWidget);
  });

  testWidgets('product description', (widgetTester) async {
    await mockNetworkImagesFor(() => widgetTester.pumpWidget(MaterialApp(
            home: ProductDescriptionScreen(
          productDetailName: 'name',
          productDetailShopName: 'shop name',
          productDetailPrice: '1.00',
          productDetailCategory: 'category',
          productDetailDescription: 'description',
          productDetailImages:
              'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
          deleted: 'false',
          iconsButtons: true,
          productDetailId: 'product detail id',
          listingId: 'listing id',
          sellerId: null,
        ))));

    expect(find.text('name'), findsOneWidget);
    expect(find.text('\$1.00'), findsOneWidget);
    expect(find.text('by: shop name'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.text('Visit Shop'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Favourites'), findsOneWidget);
  });
  testWidgets('Home', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
        home: HomeScreen(currentCategory: 'Popular', sort: "Default")));
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Favourites'), findsOneWidget);
    expect(find.text('Search Listings'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);
  });
}
