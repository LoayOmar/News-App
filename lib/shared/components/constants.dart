import 'package:flutter/cupertino.dart';
import 'package:news_app/modules/login/login_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';


void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value == true) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1.800}}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String? token = '';

String? uId = '';
