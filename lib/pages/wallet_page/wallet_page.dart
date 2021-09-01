import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_alert.dart';
import 'package:goop/pages/components/goop_available_balance.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_pix_info.dart';
import 'package:goop/pages/components/goop_wallet_completed.dart';
import 'package:goop/pages/components/goop_wallet_verification.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends StateGoop<WalletPage> {
  final bool isCompleted = false;

  List listFaturasJson;

  void carteira_Load() async {
    try {
      listFaturasJson = await serviceNotifier.genericService.getCarteira();
    } finally {
      loadFinish();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    carteira_Load();
  }

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
        body: loading
            ? inProgress()
            : RefreshIndicator(
                strokeWidth: 3,
                color: goopColors.red,
                onRefresh: () async {
                  carteira_Load();
                },
                child: Column(
                  children: [
                    paddingT(30),
                    Container(
                      color: Colors.black12,
                      child: Row(
                        children: [
                          Text('Data'),
                          Expanded(child: paddingZ()),
                          Text('Ref. Pagamento'),
                          Expanded(child: paddingZ()),
                          Text('Total'),
                          Expanded(child: paddingZ()),
                          Text('Situação'),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: listFaturasJson.length,
                      separatorBuilder: (_, index) => SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final faturaJson = listFaturasJson[index];

                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(JsonGet.DatetimeStr(faturaJson, 'date_invoice')),
                                  Expanded(child: paddingZ()),
                                  Text(JsonGet.Str(faturaJson, 'reference')),
                                  Expanded(child: paddingZ()),
                                  Text(JsonGet.DoubleCurrency(faturaJson, 'amount_total_signed')),
                                  Expanded(child: paddingZ()),
                                  Text(strSubstList(JsonGet.Str(faturaJson, 'state'), [
                                    'draft',
                                    'Provisório',
                                    'open',
                                    'Aberto',
                                    'in_payment',
                                    'Em Pagamento',
                                    'paid',
                                    'Pago',
                                    'cancel',
                                    'Cancelado'
                                  ]))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ));
  }
}
