import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/info.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class GoopCard extends StatelessWidget {
  final InfoMission info;
  final Color border;
  final bool showPrinceAndTime;

  const GoopCard({
    Key key,
    @required this.info,
    this.border = GoopColors.grey,
    this.showPrinceAndTime = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.mission_about,
          arguments: info,
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
              info.title,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              info.address,
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              info.content,
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
                        'R\$ ${info.price.toStringAsFixed(2)}',
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
                        info.time,
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
