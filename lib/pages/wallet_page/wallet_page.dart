import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class WalletPage extends StatelessWidget {
  final bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: 40,
          child: SvgPicture.asset(GoopImages.wallet_logo),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: SvgPicture.asset(GoopImages.money),
            ),
            !isCompleted
                ? Column(
                    children: [
                      Text(
                        'Saldo Disponível',
                        style: TextStyle(
                          color: GoopColors.green,
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
                      Text(
                        'R\$ 100,00',
                        style: TextStyle(
                          color: GoopColors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: GoopColors.neutralGrey,
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
                  )
                : Column(
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
                  ),
            SizedBox(height: 20),
            GoopButton(
              text: 'Sacar para Conta',
              action: () {},
            )
          ],
        ),
      ),
    );
  }
}
