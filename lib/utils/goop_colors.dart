import 'package:flutter/material.dart';
import 'package:goop/utils/global.dart';

class GoopColors {

  Color getColor(colorLight, colorBlack) => (globalConfig.darkMode == true) ? colorBlack : colorLight;
  // Color getColor(colorLight, colorBlack) => colorBlack;
  // Color getColor(colorLight, colorBlack) => colorLight;

  Color get black => getColor(Colors.black, Colors.white);
  Color get black87 => getColor(Colors.black87, Colors.white70);
  Color get white => getColor(Colors.white, Colors.white10);
  Color get whitePrimaryColorTheme => getColor(Colors.white, Colors.black);
  Color get neutralGrey => getColor(Color(0xFFF0F5F7), Colors.black);
  Color get borderCard => getColor(Color(0xFF1C1B1B), Color(0xFF1C1B1B));

  Color get grey => getColor(Colors.grey, Colors.grey);
  Color get grey400 => getColor(Colors.grey[400], Colors.grey[400]);
  Color get textGrey => getColor(Color(0xFF808B96), Color(0xFF808B96));
  Color get pink => getColor(Color(0xFFAE007A), Color(0xFFAE007A));
  Color get purple => getColor(Color(0xFF502784), Color(0xFF502784));
  Color get orange => getColor(Color(0xFFEC421E), Color(0xFFAE007A));

  //bege
  Color get bege => getColor(Color(0xFFFFB200), Color(0xFFFFB200));
  Color get green => getColor(Color(0xFF7DB72D), Color(0xFF7DB72D));

  // neutral green
  Color get neutralGreen => getColor(Color(0xFF199685), Color(0xFF199685));
  Color get blue => getColor(Color(0xFF0061AC), Color(0xFF0061AC));
  Color get lightBlue => getColor(Colors.lightBlue, Colors.lightBlue);
  Color get red => getColor(Color(0xFFDF0047), Color(0xFFFFB200));
  Color get redSplash => getColor(Color(0xFFDF0D47), Color(0xFFDF0D47));
  Color get darkBlue => getColor(Color(0xFF20243A), Colors.blueGrey);
  Color get deepPurple => getColor(Colors.deepPurple, Colors.green);
  Color get deepPurple900 => getColor(Colors.deepPurple[900], Colors.green);
  // Color get inProgressCard => getColor(Color(0xFFFDEEF2) , Color(0xFF808B96));
  Color get inProgressCard => getColor(Color(0xFFFDEEF2) , Colors.amberAccent.withOpacity(.2));
  Color get brown => getColor(Colors.brown, Colors.brown);
  Color get teal => getColor(Colors.teal, Colors.teal);
  Color get headline1 => getColor(Color(0xFF808080), Color(0xFF808080));
}
