class ServiceCategory {
  final String id;
  final String name;
  final String description;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory ServiceCategory.fromMap(Map<String, dynamic> map) {
    return ServiceCategory(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
