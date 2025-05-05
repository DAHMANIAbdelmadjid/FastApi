class Doctor {
  final int id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final String city;
  final String address;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.city,
    required this.address,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as int,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      city: json['city'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'imageUrl': imageUrl,
      'rating': rating,
      'city': city,
      'address': address,
    };
  }
}
