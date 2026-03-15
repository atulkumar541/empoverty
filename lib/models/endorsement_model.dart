import 'package:uuid/uuid.dart';

enum EndorsementType { text, audio, video, letter }

class Endorsement {
  final String id;
  final String shopkeeperId;
  final String workerId;
  final String message;
  final EndorsementType type;
  final String? mediaUrl;
  final double rating;
  final DateTime createdAt;

  Endorsement({
    String? id,
    required this.shopkeeperId,
    required this.workerId,
    required this.message,
    required this.type,
    this.mediaUrl,
    this.rating = 5.0,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopkeeperId': shopkeeperId,
      'workerId': workerId,
      'message': message,
      'type': type.toString(),
      'mediaUrl': mediaUrl,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Endorsement.fromMap(Map<String, dynamic> map) {
    return Endorsement(
      id: map['id'],
      shopkeeperId: map['shopkeeperId'],
      workerId: map['workerId'],
      message: map['message'],
      type: EndorsementType.values
          .firstWhere((e) => e.toString() == map['type']),
      mediaUrl: map['mediaUrl'],
      rating: map['rating']?.toDouble() ?? 5.0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
