import 'package:uuid/uuid.dart';

enum UserType { shopkeeper, serviceProvider, customer }

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserType userType;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  User({
    String? id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    this.address,
    this.latitude,
    this.longitude,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType.toString(),
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      userType: UserType.values
          .firstWhere((e) => e.toString() == map['userType']),
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserType? userType,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userType: userType ?? this.userType,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
