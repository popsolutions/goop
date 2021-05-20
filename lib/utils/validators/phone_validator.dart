String validatePhone(String phone) {
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
