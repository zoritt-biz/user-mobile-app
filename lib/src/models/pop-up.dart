class PopUp {
  final String id;
  final String image;
  final String category;

  PopUp({
    this.id,
    this.image,
    this.category,
  });

  factory PopUp.fromJson(Map<String, dynamic> json) {
    return PopUp(
      id: json['_id'],
      image: json['image'],
      category: json['category'],
    );
  }
}
