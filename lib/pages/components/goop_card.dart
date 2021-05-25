import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class GoopCard extends StatelessWidget {
  final MissionModel mission;
  final Color border;
  final bool showPrinceAndTime;
  final bool goToPage;

  const GoopCard({
    Key key,
    @required this.mission,
    this.border = GoopColors.grey,
    this.showPrinceAndTime = true,
    this.goToPage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !goToPage
          ? null
          : () {
              Navigator.pushNamed(
                context,
                Routes.mission_about,
                arguments: mission,
              );
            },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: border),
        ),
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [
            Text(
              mission.name ?? '',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              mission.address ?? '',
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              mission.subject ?? '',
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(
                color: Colors.black,
              ),
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
                        'R\$ ${mission.reward.toStringAsFixed(2) ?? 0.00}',
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
                        mission.time ?? '',
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
