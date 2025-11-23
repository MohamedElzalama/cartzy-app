class CategoryEntity {
  const CategoryEntity({
    this.id = 1,
    this.name = '',
    this.slug = '',
    this.image = '',
  });

  final int id;
  final String name;
  final String slug;
  final String image;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
    };
  }

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      slug: map['slug'] as String,
      image: map['image'] as String,
    );
  }
}
