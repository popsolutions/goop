import 'package:flutter/material.dart';

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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...sizeList
                .map(
                  (e) => Container(
                    width: 40,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ],
    );
  }
}
