import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/utils/global.dart';

class PreviewPage extends StatelessWidget {
  final File file;
  PreviewPage(this.file);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(32),
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: goopColors.black.withOpacity(.5),
                            child: IconButton(
                              icon: Icon(
                                Icons.check,
                                color: goopColors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                goop_LibComponents.navigatorPop(context, file);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(32),
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: goopColors.black.withOpacity(.5),
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: goopColors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                goop_LibComponents.navigatorPop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
