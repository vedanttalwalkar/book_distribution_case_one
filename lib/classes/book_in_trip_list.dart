class BookInTripList {
  final String? category;
  final String name;
  final double? score;
  final num? multiplier;
  final num price;
  final int quantity;
  final double totalPrice;
  const BookInTripList({
    required this.totalPrice,
    required this.quantity,
    this.category,
    required this.name,
    this.score,
    this.multiplier,
    required this.price,
  });
  factory BookInTripList.fromJs(Map<String, dynamic> document) {
    return BookInTripList(
        totalPrice: document["totalPrice"],
        quantity: document["quantity"],
        price: document["price"],
        name: document["name"],
        category: document["category"],
        multiplier: document["multiplier"],
        score: document["score"]);
  }
  toJson() {
    return {
      "totalPrice": totalPrice,
      "category": category,
      "name": name,
      "score": score,
      "multiplier": multiplier,
      "price": price,
      "quantity": quantity,
    };
  }
}
