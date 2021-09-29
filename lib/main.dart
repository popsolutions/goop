import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/config/widgets_router.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/global.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  prefsGoop.init(false);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BuildContext myAppContext;

  void rebuildAllChildren() {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (myAppContext as Element).visitChildren(rebuild);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    globalConfig.readconfJson();
  }

  @override
  Widget build(BuildContext context) {
    if (myAppContext == null) {
      myAppContext = context;
      globalRebuildAllChildren = rebuildAllChildren;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return ChangeNotifierProvider(
        create: (context) => ServiceNotifier(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // colorScheme:
            //     ThemeData().colorScheme.copyWith(primary: Colors.white),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: goopColors.headline1,
              ),
              headline2: TextStyle(
                color: goopColors.deepPurple900,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              headline3: TextStyle(
                fontWeight: FontWeight.bold,
                color: goopColors.black,
                fontSize: 20,
              ),
              headline4: TextStyle(
                decoration: TextDecoration.underline,
                color: goopColors.red,
                fontSize: 14,
              ),
              headline5: TextStyle(
                color: goopColors.deepPurple900,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            splashColor: goopColors.redSplash,
            scaffoldBackgroundColor: goopColors.white,
            appBarTheme: AppBarTheme(elevation: 0),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              contentPadding: EdgeInsets.only(
                left: 23,
                top: 25,
                bottom: 25,
              ),
              fillColor: goopColors.neutralGrey,
              hintStyle: TextStyle(
                color: goopColors.textGrey,
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
            primaryColor: goopColors.whitePrimaryColorTheme,
            primarySwatch: goopColors.lightBlue,
          ),
          routes: WidgetsRouter.routes,
          initialRoute: Routes.initial,
        ));
  }
}
