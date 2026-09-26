import 'package:flutter/foundation.dart';
import '../models/event.dart';

class EventProvider extends ChangeNotifier {
  final List<DessertItem> _desserts = [
    DessertItem(
      id: 'tiramisu-cart',
      name: 'Pistachio Tiramisu',
      italianName: 'Tiramisù al Pistacchio',
      description: 'Layers of espresso-soaked savoiardi, mascarpone cream, and Bronte pistachio.',
      price: 13,
      emoji: '🟢',
    ),
    DessertItem(
      id: 'profiteroles-cart',
      name: 'Profiteroles',
      italianName: 'Profiteroles al Cioccolato',
      description: 'Choux puffs with vanilla gelato, warm Valrhona dark chocolate sauce.',
      price: 12,
      emoji: '⚪',
    ),
    DessertItem(
      id: 'crostata-cart',
      name: 'Seasonal Crostata',
      italianName: 'Crostata di Stagione',
      description: 'Rustic pastry tart with pastry cream and today\'s seasonal fruit.',
      price: 11,
      emoji: '🥧',
    ),
    DessertItem(
      id: 'zuppa-inglese',
      name: 'Zuppa Inglese',
      italianName: 'Zuppa Inglese',
      description: 'Trifle-style dessert with Alchermes-soaked sponge, custard, and meringue.',
      price: 12,
      emoji: '🍮',
    ),
    DessertItem(
      id: 'gelato',
      name: 'House Gelato',
      italianName: 'Gelato della Casa',
      description: 'Three scoops of rotating seasonal gelato — ask your server for today\'s flavors.',
      price: 9,
      emoji: '🍨',
    ),
    DessertItem(
      id: 'panna-cotta',
      name: 'Panna Cotta',
      italianName: 'Panna Cotta al Miele',
      description: 'Silky honey panna cotta with honeycomb, seasonal berries, and lavender.',
      price: 11,
      emoji: '🍯',
    ),
  ];

  List<DessertItem> get desserts => _desserts;

  int get cartCount => _desserts.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotal => _desserts.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  void increment(String id) {
    final item = _desserts.firstWhere((d) => d.id == id);
    item.quantity++;
    notifyListeners();
  }

  void decrement(String id) {
    final item = _desserts.firstWhere((d) => d.id == id);
    if (item.quantity > 0) {
      item.quantity--;
      notifyListeners();
    }
  }

  void clearCart() {
    for (final item in _desserts) {
      item.quantity = 0;
    }
    notifyListeners();
  }

  final List<Event> _events = const [
    Event(
      id: 'private-dining',
      title: 'Private Dining Room',
      description: 'Host an intimate dinner for family or colleagues in our beautifully appointed private dining room. We craft custom multi-course Italian menus tailored to your group.',
      capacity: 'Up to 20 guests',
      priceRange: 'From \$85 per person',
      features: [
        'Custom multi-course menu by Chef Barban',
        'Dedicated sommelier for wine pairing',
        'Private entrance option',
        'AV equipment available',
        'Dietary accommodations',
      ],
      emoji: '🕯️',
      type: 'private',
    ),
    Event(
      id: 'family-style',
      title: 'Family-Style Dining',
      description: 'Perfect for groups of 7 or more. Share the full Briscola experience together — platters of pasta, antipasti boards, and whole roasted meats served in the center of the table.',
      capacity: '7–30 guests',
      priceRange: '\$65–\$95 per person',
      features: [
        'Curated family-style menu',
        'House-made bread & olive oil',
        'Wine pairing optional',
        'Dessert cart included',
        'Semi-private dining space',
      ],
      emoji: '🍽️',
      type: 'family',
    ),
    Event(
      id: 'catering',
      title: 'Off-Site Catering',
      description: 'Bring the Briscola experience to your venue. From intimate dinner parties to corporate events, Chef Barban\'s team brings everything — food, staff, and equipment.',
      capacity: '20–150 guests',
      priceRange: 'Custom quote',
      features: [
        'Full-service setup & breakdown',
        'Custom Italian menu',
        'Professional wait staff',
        'Equipment & rentals included',
        'Staffed bar service available',
      ],
      emoji: '🚚',
      type: 'catering',
    ),
    Event(
      id: 'wine-dinner',
      title: 'Italian Wine Dinner',
      description: 'A themed multi-course dinner with a curated Italian wine producer. Join us monthly for deep dives into Barolo, Brunello, Soave, and more — with producers presenting their wines.',
      capacity: '20–40 guests',
      priceRange: '\$120 per person (all-inclusive)',
      features: [
        '5-course tasting menu',
        'Producer presentation',
        'Wine pairing every course',
        'Wine educator host',
        'Take-home wine notes',
      ],
      emoji: '🍾',
      type: 'private',
    ),
  ];

  List<Event> get events => _events;
}
