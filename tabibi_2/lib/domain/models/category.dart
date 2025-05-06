class Category {
  final String id;
  final String name;
  final String iconPath;
  final String description;

  const Category({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.description,
  });

  static List<Category> getMedicalCategories() {
    return [
      const Category(
        id: 'cardiology',
        name: 'Cardiology',
        iconPath: 'assets/icon/cardiology.png',
        description: 'Heart and blood vessel specialists',
      ),
      const Category(
        id: 'pediatrics',
        name: 'Pediatrics',
        iconPath: 'assets/icon/pediatrics.png',
        description: 'Child health specialists',
      ),
      const Category(
        id: 'neurology',
        name: 'Neurology',
        iconPath: 'assets/icon/neurology.png',
        description: 'Brain and nervous system specialists',
      ),
      const Category(
        id: 'orthopedics',
        name: 'Orthopedics',
        iconPath: 'assets/icon/arthritis.png',
        description: 'Bone and joint specialists',
      ),
      const Category(
        id: 'dentistry',
        name: 'Dentistry',
        iconPath: 'assets/icon/tooth.png',
        description: 'Dental care specialists',
      ),
      const Category(
        id: 'dermatology',
        name: 'Dermatology',
        iconPath: 'assets/icon/skin.png',
        description: 'Skin specialists',
      ),
    ];
  }
}

    