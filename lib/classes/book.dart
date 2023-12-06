class Book {
  final String? category;
  final String name;
  final double? score;
  final num? multiplier;
  final num price;
  const Book({
    this.category,
    required this.name,
    this.score,
    this.multiplier,
    required this.price,
  });
  factory Book.fromJs(Map<String, dynamic> document) {
    return Book(
      price: document["price"],
      name: document["name"],
      category: document["category"],
      multiplier: document["multiplier"],
      score: document["score"]
    );
  }
  toJson() {
    return {
      "category": category,
      "name": name,
      "score": score,
      "multiplier": multiplier,
      "price": price,
    };
  }
}
