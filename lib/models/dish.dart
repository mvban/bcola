// Models
class Dish {
  final String id;
  final String name;
  final String italianName;
  final String category; // Antipasti, Primi, Secondi, Dolci
  final String description;
  final String story;
  final double price;
  final String region;
  final String regionEmoji;
  final List<String> ingredients;
  final String pairingSuggestion;
  final bool isSignature;
  final String emoji;

  const Dish({
    required this.id,
    required this.name,
    required this.italianName,
    required this.category,
    required this.description,
    required this.story,
    required this.price,
    required this.region,
    required this.regionEmoji,
    required this.ingredients,
    required this.pairingSuggestion,
    this.isSignature = false,
    required this.emoji,
  });
}
