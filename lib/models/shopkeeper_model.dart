import 'package:uuid/uuid.dart';

class Shopkeeper {
  final String id;
  final String userId;
  final String shopName;
  final String description;
  final List<String> offeredServices; // Electrician, Plumber, etc.
  final String? shopImageUrl;
  final double? latitude;
  final double? longitude;
  final String? address;
  final List<String> endorsedWorkerIds;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;

  Shopkeeper({
    String? id,
    required this.userId,
    required this.shopName,
    required this.description,
    required this.offeredServices,
    this.shopImageUrl,
    this.latitude,
    this.longitude,
    this.address,
    List<String>? endorsedWorkerIds,
    this.rating = 0.0,
    this.reviewCount = 0,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        endorsedWorkerIds = endorsedWorkerIds ?? [],
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'shopName': shopName,
      'description': description,
      'offeredServices': offeredServices,
      'shopImageUrl': shopImageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'endorsedWorkerIds': endorsedWorkerIds,
      'rating': rating,
      'reviewCount': reviewCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Shopkeeper.fromMap(Map<String, dynamic> map) {
    return Shopkeeper(
      id: map['id'],
      userId: map['userId'],
      shopName: map['shopName'],
      description: map['description'],
      offeredServices: List<String>.from(map['offeredServices']),
      shopImageUrl: map['shopImageUrl'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      endorsedWorkerIds: List<String>.from(map['endorsedWorkerIds'] ?? []),
      rating: map['rating']?.toDouble() ?? 0.0,
      reviewCount: map['reviewCount'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Shopkeeper copyWith({
    String? id,
    String? userId,
    String? shopName,
    String? description,
    List<String>? offeredServices,
    String? shopImageUrl,
    double? latitude,
    double? longitude,
    String? address,
    List<String>? endorsedWorkerIds,
    double? rating,
    int? reviewCount,
    DateTime? createdAt,
  }) {
    return Shopkeeper(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      shopName: shopName ?? this.shopName,
      description: description ?? this.description,
      offeredServices: offeredServices ?? this.offeredServices,
      shopImageUrl: shopImageUrl ?? this.shopImageUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      endorsedWorkerIds: endorsedWorkerIds ?? this.endorsedWorkerIds,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
