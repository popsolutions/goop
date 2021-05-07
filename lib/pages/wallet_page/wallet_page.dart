import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/pages/components/goop_alert.dart';
import 'package:goop/pages/components/goop_available_balance.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_pix_info.dart';
import 'package:goop/pages/components/goop_wallet_completed.dart';
import 'package:goop/pages/components/goop_wallet_verification.dart';
import 'package:goop/utils/goop_images.dart';

class WalletPage extends StatelessWidget {
  final bool isCompleted = true; //ALTERNAR PARA MUDAR TELA

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
            !isCompleted ? GoopAvailableBalance() : GoopPixInfo(),
            SizedBox(height: 20),
            GoopButton(
              text: 'Sacar para Conta',
              action: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return GoopAlert(
                      contet: !isCompleted
                          ? GoopWalletVerification()
                          : GoopWalletCompleted(),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
