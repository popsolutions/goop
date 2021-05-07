import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_colors.dart';

import 'goop_images.dart';

class GoopTerms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: Color(0XFFF0F5F7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Termos de Uso',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Stack(
              alignment: Alignment(0, 0),
              children: [
                SvgPicture.asset(
                  GoopImages.close,
                  width: 40,
                ),
                Text(
                  'X',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: GoopColors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      content: Text(
        '''
          Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna.
          Nunc viverra imperdiet enim. Fusce est. Vivamus a tellus.
          Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin pharetra nonummy pede. Mauris et orci.
          Aenean nec lorem. In porttitor. Donec laoreet nonummy augue.
          Suspendisse dui purus, scelerisque at, vulputate vitae, pretium mattis, nunc. Mauris eget neque at sem venenatis eleifend. Ut nonummy.
          Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa.
''',
        textAlign: TextAlign.justify,
      ),
    );
  }
}
