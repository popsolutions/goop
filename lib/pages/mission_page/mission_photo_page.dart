import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Mission_photo_page extends StatefulWidget {
  @override
  _Mission_photo_pageState createState() => _Mission_photo_pageState();
}

class _Mission_photo_pageState extends State<Mission_photo_page> {
  ServiceNotifier serviceNotifier;
  @override
  String archive;

  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.headline2;
    serviceNotifier = Provider.of<ServiceNotifier>(context, listen: false);
    Activity currentActivity = serviceNotifier.currentActivity;

    if ((currentActivity.measurementPhotoLinesModel != null) &&
        (archive == null)) {
      setState(() {
        archive = currentActivity.measurementPhotoLinesModel.photo;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: 60,
          child: SvgPicture.asset(GoopImages.price_comparison),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      currentActivity.name,
                      style: theme,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Divider(color: goopColors.deepPurple),
                    ),
                    SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: (archive == null)
                          ? Image.asset(
                              GoopImages.empty_profile,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            )
                          : Image.memory(
                              Base64Codec().decode(archive),
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
