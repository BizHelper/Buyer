import 'package:buyer_app/src/screens/login.dart';
import 'package:buyer_app/src/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_test.mocks.dart';

class UserMock extends Mock implements User {}

@GenerateMocks([FirebaseAuth])
void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  group("Sign in", () {
    test("no email address", () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
            email: "", password: "bizhelper00"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Please enter your email address", code: "No email"),
      );
      expect(await Auth(auth: mockFirebaseAuth).signin("", "bizhelper00"),
          "Please enter your email address");
    });

    test("invalid email address", () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
            email: "abcdef", password: "bizhelper00"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Email is badly formatted", code: "Invalid email"),
      );
      expect(await Auth(auth: mockFirebaseAuth).signin("abcdef", "bizhelper00"),
          "Email is badly formatted");
    });

    test("No password", () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
            email: "abcdef@gmail.com", password: ""),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Please enter a password", code: "No password"),
      );
      expect(await Auth(auth: mockFirebaseAuth).signin("abcdef@gmail.com", ""),
          "Please enter a password");
    });

    test("Invalid password", () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
            email: "abcdef@gmail.com", password: "abcdef"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Password is invalid", code: "Invalid password"),
      );
      expect(
          await Auth(auth: mockFirebaseAuth)
              .signin("abcdef@gmail.com", "abcdef"),
          "Password is invalid");
    });

    test("Email doesnt exist", () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
            email: "111@gmail.com", password: "abcdef"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Email is not registered", code: "Email not registered"),
      );
      expect(
          await Auth(auth: mockFirebaseAuth).signin("111@gmail.com", "abcdef"),
          "Email is not registered");
    });
  });

  group("Sign up", () {
    test("no email address", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "", password: "bizhelper00"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Please enter your email address", code: "No email"),
      );
      expect(await Auth(auth: mockFirebaseAuth).signup("", "bizhelper00"),
          "Please enter your email address");
    });

    test("invalid email address", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "abcdef", password: "bizhelper00"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Email is badly formatted", code: "Invalid email"),
      );
      expect(await Auth(auth: mockFirebaseAuth).signup("abcdef", "bizhelper00"),
          "Email is badly formatted");
    });

    test("No password", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "abcdef@gmail.com", password: ""),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Please enter a password", code: "No password"),
      );
      expect(await Auth(auth: mockFirebaseAuth).signup("abcdef@gmail.com", ""),
          "Please enter a password");
    });

    test("Invalid password", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "abcdef@gmail.com", password: "abcdef"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Password is invalid", code: "Invalid password"),
      );
      expect(
          await Auth(auth: mockFirebaseAuth)
              .signup("abcdef@gmail.com", "abcdef"),
          "Password is invalid");
    });

    test("Email doesnt exist", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "111@gmail.com", password: "abcdef"),
      ).thenAnswer(
        (_) async => throw FirebaseAuthException(
            message: "Email is not registered", code: "Email not registered"),
      );
      expect(
          await Auth(auth: mockFirebaseAuth).signup("111@gmail.com", "abcdef"),
          "Email is not registered");
    });
    /*Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    Widget makeTestableWidget({required Widget child}){
      return MaterialApp(
        home: child,
      );
    }
    testWidgets('testing', (WidgetTester tester) async{
      MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: "hioksurebye@gmail.com",
          password: "bizhelper00")).thenAnswer( (_) async => throw FirebaseAuthException(
          message: "Please enter your email address", code: "No email"));
      LoginScreen loginScreen = LoginScreen();
      await tester.pumpWidget(makeTestableWidget(child:loginScreen));
      expect(find.text("Buyer Login"), findsOneWidget);
    });

     */
  });
}
