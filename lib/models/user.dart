class UserModel {
  final String uid;
  final String email;
  final int? tripCoins;
  final int? vouchers;
  final String? profileImageUrl;
  final String? name; // có thể null nếu chưa nhập tên

  UserModel({
    required this.uid,
    required this.email,
    this.tripCoins,
    this.vouchers,
    this.profileImageUrl,
    this.name,
  });

  factory UserModel.fromFireStore(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'] ?? '',
      tripCoins: map['tripCoins'] ?? 0,
      vouchers: map['vouchers'] ?? 0,
      profileImageUrl: map['profileImageUrl'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'tripCoins': tripCoins,
      'vouchers': vouchers,
      'profileImageUrl': profileImageUrl,
    };
  }


}
