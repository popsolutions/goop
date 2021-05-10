import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/config/widgets_router.dart';
import 'package:goop/utils/goop_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        splashColor: GoopColors.redSplash,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(elevation: 0),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.only(
            left: 23,
            top: 25,
            bottom: 25,
          ),
          fillColor: GoopColors.neutralGrey,
          hintStyle: TextStyle(
            color: GoopColors.textGrey,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(55),
            ),
          ),
        ),
        primaryColor: Colors.white,
        primarySwatch: Colors.lightBlue,
      ),
      routes: WidgetsRouter.routes,
      initialRoute: Routes.splash,
    );
  }
}
