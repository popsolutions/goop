class UpdateUser {
  final int partnerId;
  final String email;
  final String phone;
  final String cnpjCpf;
  
  UpdateUser({
    this.partnerId,
    this.email,
    this.phone,
    this.cnpjCpf,
  });

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (cnpjCpf != null) 'cnpj_cpf': cnpjCpf,
    };
  }
}
