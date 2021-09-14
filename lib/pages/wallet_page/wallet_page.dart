import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends StateGoop<WalletPage> {
  final bool isCompleted = false;
  GoopColors goopColors = GoopColors();

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
          child: Image.asset(GoopImages.walletPng),
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
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    height: 60,
                    color: goopColors.redSplash,
                    child: Row(
                      children: [
                        Text(
                          'Data',
                          style: TextStyle(
                            color: goopColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: paddingZ()),
                        Text(
                          'Ref. Pagamento',
                          style: TextStyle(
                            color: goopColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: paddingZ()),
                        Text(
                          'Total',
                          style: TextStyle(
                            color: goopColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: paddingZ()),
                        Text(
                          'Situação',
                          style: TextStyle(
                            color: goopColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                      child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: listFaturasJson.length,
                    separatorBuilder: (_, index) => SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final faturaJson = listFaturasJson[index];
                      final format = DateFormat('dd/MM/yyyy');

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: goopColors.neutralGrey,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                    format.format(DateTime.now()),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Text(
                                  //   // format.format(
                                  //   //   DateTime.parse(
                                  //   //     JsonGet.DatetimeStr(
                                  //   //       faturaJson,
                                  //   //       'date_invoice',
                                  //   //     ),
                                  //   //   ),
                                  //   // ),
                                  //   JsonGet.DatetimeStr(
                                  //     faturaJson, //TODO: REVER
                                  //     'date_invoice',
                                  //   ),
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Expanded(child: paddingZ()),
                                  Text(
                                    JsonGet.Str(faturaJson, 'reference'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(child: paddingZ()),
                                  Text(
                                    'R\$ ${JsonGet.DoubleCurrency(faturaJson, 'amount_total_signed')}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(child: paddingZ()),
                                  Text(
                                    strSubstList(
                                        JsonGet.Str(faturaJson, 'state'), [
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
                                    ]),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
    );
  }
}
