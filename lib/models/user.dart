class User {
  final String sessionId;
  final int uid;
  final bool isAdmin;
  final String name;
  final String username;
  final String partnerDisplayName;
  final int companyId;
  final int partnerId;
  final bool userCompanies;

  User({
    this.sessionId,
    this.uid,
    this.isAdmin,
    this.name,
    this.username,
    this.partnerDisplayName,
    this.companyId,
    this.partnerId,
    this.userCompanies,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sessionId: json['session_id'],
      uid: json['uid'],
      isAdmin: json['is_admin'],
      name: json['name'] is! bool ? json['name'] : "N/A",
      username: json['username'] is! bool ? json['username'] : "N/A",
      partnerDisplayName: json['partner_display_name'] is! bool
          ? json['partner_display_name']
          : "N/A",
      companyId: json['company_id'],
      partnerId: json['partner_id'],
      userCompanies: json['user_companies'],
    );
  }
}
