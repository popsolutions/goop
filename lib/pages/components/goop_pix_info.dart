import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/utils/goop_images.dart';

class GoopPixInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Quanto deseja Sacar?',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Divider(
            color: Colors.black,
          ),
        ),
        Container(
          height: 70,
          child: SvgPicture.asset(GoopImages.pix),
        ),
        Container(
          width: 300,
          child: GoopButton(text: 'R\$ 100'),
        )
      ],
    );
  }
}
