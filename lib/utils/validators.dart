import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';

class Validators {
  static String validateEmail(String email) {
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

  static String validateCPF(String cpf) {
    cpf = cpf.trim();

    if (cpf.isEmpty) {
      return 'Digite um CPF';
    }
    final cpfValidate = CPFValidator.isValid(cpf);

    if (!cpfValidate) {
      return 'CPF inválido';
    }
    return null;
  }

  static String validatePhone(String phone) {
    phone = phone.trim();
    phone = phone.replaceAll('(', '');
    phone = phone.replaceAll(')', '');
    phone = phone.replaceAll('-', '');
    phone = phone.replaceAll(' ', '');

    if (phone.isEmpty) {
      return 'Digite um telefone';
    }
    if (phone.length != 11) {
      return 'Número inválido';
    }
    return null;
  }
}
