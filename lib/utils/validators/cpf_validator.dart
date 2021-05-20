import 'package:cpf_cnpj_validator/cpf_validator.dart';

String validateCPF(String cpf) {
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
