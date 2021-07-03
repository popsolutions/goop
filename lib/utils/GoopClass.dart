import 'package:goop/utils/utils.dart';

class GoopClass{
  void throwG(String message, String functionName ){
    String source ='${this.runtimeType.toString()}.$functionName';
    printL2('GoopClass.throwG\nSource: $source\nMessage: $message\n\n');
    throw FormatException(message, source);
  }
}