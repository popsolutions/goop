import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'StateGoop.dart';

class GoopCard extends StatefulWidget {
  final MissionModel currentMissionModel;
  Color border;
  final bool showPrinceAndTime;
  final bool goToPage;

  GoopCard({
    Key key,
    @required this.currentMissionModel,
    this.border,
    this.showPrinceAndTime = true,
    this.goToPage = true,
  }) : super(key: key);

  @override
  _GoopCardState createState() => _GoopCardState();
}

class _GoopCardState extends StateGoop<GoopCard> {
  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).textTheme.headline1.color);

    if (widget.border == null) widget.border = goopColors.borderCard;

    return GestureDetector(
      onTap: !widget.goToPage
          ? null
          : () async {
              await dialogProcess(() async {
                await serviceNotifier
                    .setcurrentMissionModel(widget.currentMissionModel);
              });

              navigatorPushNamed(
                Routes.mission_about,
                arguments: widget.currentMissionModel,
              );
            },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color:  widget.currentMissionModel.inProgressOrDone ? Color(0XFFFDEEF2) : goopColors.white,
          color: widget.currentMissionModel.inProgressOrDone
              ? goopColors.inProgressCard
              : goopColors.white,
          border: Border.all(
            width: widget.currentMissionModel.inProgressOrDone ? 2 : 1,
            color: (widget.currentMissionModel.inProgressOrDone == true)
                ? goopColors.red
                : widget.border,
          ),
        ),
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          children: [
            Text(
              widget.currentMissionModel.name ?? '',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              widget.currentMissionModel.address ?? '',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(color: goopColors.black),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Text(
                widget.currentMissionModel.subject ?? '',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(color: goopColors.black),
            ),
            if (widget.showPrinceAndTime)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      horizontalTitleGap: 5,
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        GoopImages.wallet,
                        width: 20,
                      ),
                      title: Text(
                        'R\$ ${widget.currentMissionModel.reward.toStringAsFixed(2) ?? 0.00}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigatorPushReplacementNamed(
                        Routes.home,
                        arguments: [
                          widget
                              .currentMissionModel.establishmentModel.latitude,
                          widget
                              .currentMissionModel.establishmentModel.longitude,
                        ],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        GoopImages.local,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
            Text(
              widget.currentMissionModel.statusText(),
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: goopColors.red,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
