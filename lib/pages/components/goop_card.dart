import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'StateGoop.dart';

class GoopCard extends StatefulWidget {
  final MissionModel currentMissionModel;
  final Color border;
  final bool showPrinceAndTime;
  final bool goToPage;

  const GoopCard({
    Key key,
    @required this.currentMissionModel,
    this.border = GoopColors.grey,
    this.showPrinceAndTime = true,
    this.goToPage = true,
  }) : super(key: key);

  @override
  _GoopCardState createState() => _GoopCardState();
}

class _GoopCardState extends StateGoop<GoopCard> {
  @override
  Widget build(BuildContext context) {
    final inProgress = widget.currentMissionModel.inProgress;

    return GestureDetector(
      onTap: !widget.goToPage
          ? null
          : () async {
              await dialogProcess(() async {
                await serviceNotifier
                    .setcurrentMissionModel(widget.currentMissionModel);
              });

              Navigator.pushNamed(
                context,
                Routes.mission_about,
                arguments: widget.currentMissionModel,
              );
            },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: inProgress ? Color(0XFFFDEEF2) : Colors.white,
          border: Border.all(
            width: inProgress ? 2 : 1,
            color: (inProgress == true) ? GoopColors.red : widget.border,
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
              child: Divider(color: Colors.black),
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
              child: Divider(color: Colors.black),
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
                      Navigator.pushNamed(
                        context,
                        Routes.home,
                        // arguments: {
                        //   'latitude': 1,
                        //   'longitude': 1,
                        // },
                      ); //TODO: CENTRALIZAR NO PIN NO QUAL FOI CLICADO
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        GoopImages.local,
                        width: 20,
                      ),
                    ),
                  ),
                  // Flexible(
                  //   child: ListTile(
                  //     minLeadingWidth: 0,
                  //     horizontalTitleGap: 5,
                  //     contentPadding: EdgeInsets.zero,
                  //     leading: SvgPicture.asset(
                  //       GoopImages.local,
                  //       width: 20,
                  //     ),
                  //     title: Text(
                  //       widget.currentMissionModel.time ?? '',
                  //       style: Theme.of(context).textTheme.headline1,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
