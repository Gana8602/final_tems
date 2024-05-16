class UserRoles {
  final int id;
  final String roleName;
  UserRoles({
    required this.id,
    required this.roleName,
  });

  factory UserRoles.fromJson(Map<String, dynamic> json) {
    return UserRoles(
      id: json['roleId'],
      roleName: json['roleName'],
    );
  }
}
