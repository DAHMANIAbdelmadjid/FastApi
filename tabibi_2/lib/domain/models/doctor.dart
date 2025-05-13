class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String city;
  final String address;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.city,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'].toString(),
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'city': city,
      'address': address,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }
}
