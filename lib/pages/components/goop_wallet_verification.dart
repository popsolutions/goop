import 'package:flutter/material.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class GoopWalletVerification extends StatelessWidget {
  final sizeList = List.generate(7, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      child: Column(
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
          SizedBox(height: 15),
          Container(
            child: OTPTextField(
              length: 7,
              otpFieldStyle: OtpFieldStyle(
                focusBorderColor: GoopColors.red,
              ),
              fieldWidth: 33,
              style: TextStyle(fontSize: 15),
              width: double.infinity,
              textFieldAlignment: MainAxisAlignment.center,
              onCompleted: (pin) {
                printL("Completed: " + pin);
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
