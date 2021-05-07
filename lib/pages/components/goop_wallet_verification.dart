import 'package:flutter/material.dart';
import 'package:goop/pages/components/goop_close.dart';
import 'package:goop/utils/goop_colors.dart';

class GoopWalletVerification extends StatelessWidget {
  final sizeList = List.generate(7, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Para a sua segurança',
          style: Theme.of(context).textTheme.headline1,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .5,
          child: Divider(
            color: Colors.black,
          ),
        ),
        Text(
          'Digite sua senha para concluir a solicitação.',
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...sizeList
                .map(
                  (e) => Container(
                    margin: EdgeInsets.only(right: 4),
                    width: 35,
                    height: 35,
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: GoopColors.red,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: GoopColors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
