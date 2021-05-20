import 'package:email_validator/email_validator.dart';

String validateEmail(String email) {
  email = email.trim();

  if (email.isEmpty) {
    return 'Digite um Email';
  }
  final emailValid = EmailValidator.validate(email);

  if (!emailValid) {
    return 'Email inválido';
  }
  return null;
}
