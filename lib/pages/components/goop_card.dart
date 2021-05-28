import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class GoopCard extends StatelessWidget {
  final MissionDto missionDto;
  final Color border;
  final bool showPrinceAndTime;
  final bool goToPage;

  const GoopCard({
    Key key,
    @required this.missionDto,
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
                context, Routes.mission_about,
                arguments: missionDto,
                //TODO: FAZER COM QUE PASSE O DTO PARA PROXIMA PAGINA
              );
            },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: border),
        ),
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          children: [
            Text(
              missionDto.nameEstablishment ?? '',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              missionDto.addressEstablishment ?? '',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              missionDto.subject ?? '',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
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
                        'R\$ ${missionDto.reward.toStringAsFixed(2) ?? 0.00}',
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
                        missionDto.time ?? '',
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
