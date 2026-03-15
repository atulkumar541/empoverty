import 'package:uuid/uuid.dart';

class Worker {
  final String id;
  final String userId;
  final String name;
  final String? phone;
  final String category; // Electrician, Plumber, Carpenter, etc.
  final String? bio;
  final List<String> skills;
  final List<String> certificateUrls;
  final List<String> endorsementIds;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? profileImageUrl;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final DateTime createdAt;

  Worker({
    String? id,
    required this.userId,
    required this.name,
    this.phone,
    required this.category,
    this.bio,
    List<String>? skills,
    List<String>? certificateUrls,
    List<String>? endorsementIds,
    this.latitude,
    this.longitude,
    this.address,
    this.profileImageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isVerified = false,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        skills = skills ?? [],
        certificateUrls = certificateUrls ?? [],
        endorsementIds = endorsementIds ?? [],
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'category': category,
      'bio': bio,
      'skills': skills,
      'certificateUrls': certificateUrls,
      'endorsementIds': endorsementIds,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'profileImageUrl': profileImageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      phone: map['phone'],
      category: map['category'],
      bio: map['bio'],
      skills: List<String>.from(map['skills'] ?? []),
      certificateUrls: List<String>.from(map['certificateUrls'] ?? []),
      endorsementIds: List<String>.from(map['endorsementIds'] ?? []),
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      profileImageUrl: map['profileImageUrl'],
      rating: map['rating']?.toDouble() ?? 0.0,
      reviewCount: map['reviewCount'] ?? 0,
      isVerified: map['isVerified'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Worker copyWith({
    String? id,
    String? userId,
    String? name,
    String? phone,
    String? category,
    String? bio,
    List<String>? skills,
    List<String>? certificateUrls,
    List<String>? endorsementIds,
    double? latitude,
    double? longitude,
    String? address,
    String? profileImageUrl,
    double? rating,
    int? reviewCount,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return Worker(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      category: category ?? this.category,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      certificateUrls: certificateUrls ?? this.certificateUrls,
      endorsementIds: endorsementIds ?? this.endorsementIds,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
