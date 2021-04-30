import 'package:flutter/material.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/config/widgets_router.dart';
import 'package:goop/pages/components/goop_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: const EdgeInsets.only(left: 23, top: 25, bottom: 25),
          fillColor: GoopColors.neutralGrey,
          hintStyle: TextStyle(
            color: GoopColors.grey,
            fontSize: 21,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(55)),
          ),
        ),
        primarySwatch: Colors.lightBlue,
      ),
      routes: WidgetsRouter.routes,
      initialRoute: Routes.login,
    );
  }
}
