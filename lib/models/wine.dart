class Wine {
  final String id;
  final String name;
  final String producer;
  final String region;
  final String grape;
  final String type; // red, white, sparkling, rosé
  final String vintage;
  final double priceGlass;
  final double priceBottle;
  final String tastingNotes;
  final String story;
  final List<String> pairings;
  final String emoji;

  const Wine({
    required this.id,
    required this.name,
    required this.producer,
    required this.region,
    required this.grape,
    required this.type,
    required this.vintage,
    required this.priceGlass,
    required this.priceBottle,
    required this.tastingNotes,
    required this.story,
    required this.pairings,
    required this.emoji,
  });
}

class Cocktail {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final double price;
  final String emoji;

  const Cocktail({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.price,
    required this.emoji,
  });
}
