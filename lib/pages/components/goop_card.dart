import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/utils.dart';
import 'package:provider/provider.dart';

class GoopCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);
    final inProgress = currentMissionModel.inProgress;

    return GestureDetector(
      onTap: !goToPage
          ? null
          : () async {
              showProgressDialog(context, 'Aguarde');
              await Future.delayed(Duration(seconds: 3));
              await serviceNotifier
                  .setcurrentMissionModel(currentMissionModel);
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                Routes.mission_about,
                arguments: currentMissionModel,
              );
            },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: inProgress ? Color(0XFFFDEEF2) : Colors.white,
          border: Border.all(
            width: inProgress ? 2 : 1,
            color: (inProgress == true) ? GoopColors.red : border,
          ),
        ),
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          children: [
            Text(
              currentMissionModel.name ?? '',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              currentMissionModel.address ?? '',
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
                currentMissionModel.subject ?? '',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(color: Colors.black),
            ),
            if (showPrinceAndTime)
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
                        'R\$ ${currentMissionModel.reward.toStringAsFixed(2) ?? 0.00}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      minLeadingWidth: 0,
                      horizontalTitleGap: 5,
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        GoopImages.local,
                        width: 20,
                      ),
                      title: Text(
                        currentMissionModel.time ?? '',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
