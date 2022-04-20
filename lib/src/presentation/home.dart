import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_with_signup/src/containers/user_container.dart';
import 'package:flutter_firebase_with_signup/src/models/app_user.dart';
import 'package:flutter_firebase_with_signup/src/presentation/home_page.dart';
import 'package:flutter_firebase_with_signup/src/presentation/login_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser? user) {
        if (user != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
