import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/http_overrides.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/modules/login/login_screen.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');

  HttpOverrides.global = new MyHttpOverrides();

  BlocOverrides.runZoned(
        () => runApp(MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: CacheHelper.getData(key: 'isDark') ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: token == null ? LoginScreen() : NewsLayout(),
        );
        },
      ),
    );
  }
}


