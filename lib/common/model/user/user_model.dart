class UserModel {
  final String id;
  int coins;
  final bool premium;

  UserModel({required this.id, required this.coins, required this.premium});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], coins: json['coins'], premium: json['premium']);
  }
}
