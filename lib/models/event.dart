class DessertItem {
  final String id;
  final String name;
  final String italianName;
  final String description;
  final double price;
  final String emoji;
  final bool isAvailable;
  int quantity;

  DessertItem({
    required this.id,
    required this.name,
    required this.italianName,
    required this.description,
    required this.price,
    required this.emoji,
    this.isAvailable = true,
    this.quantity = 0,
  });
}

class Event {
  final String id;
  final String title;
  final String description;
  final String capacity;
  final String priceRange;
  final List<String> features;
  final String emoji;
  final String type; // private, catering, family

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.capacity,
    required this.priceRange,
    required this.features,
    required this.emoji,
    required this.type,
  });
}
