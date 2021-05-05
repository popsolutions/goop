import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/pages/components/goop_images.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 80,
          child: SvgPicture.asset(GoopImages.cadastro),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(),
          ],
        ),
      ),
    );
  }
}
