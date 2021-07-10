import 'package:flutter/material.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_colors.dart';

class GoopAvailableBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Saldo Disponível',
          style: TextStyle(
            color: goopColors.green,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Divider(
            color: goopColors.black,
          ),
        ),
        Text(
          'R\$ 100,00',
          style: TextStyle(
            color: goopColors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: goopColors.neutralGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Text(
            '26 de Novembro | Saldo: R\$ 33,00',
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Realizou um Saque',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    '- R\$ 33,00',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pagamento Recebido',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'R\$ 33,00',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
