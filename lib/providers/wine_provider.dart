import 'package:flutter/foundation.dart';
import '../models/wine.dart';

class WineProvider extends ChangeNotifier {
  String _selectedType = 'All';

  String get selectedType => _selectedType;

  void setType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  List<String> get types => ['All', 'Red', 'White', 'Sparkling', 'Rosé'];

  List<Wine> get filteredWines {
    if (_selectedType == 'All') return _wines;
    return _wines.where((w) => w.type.toLowerCase() == _selectedType.toLowerCase()).toList();
  }

  List<Cocktail> get cocktails => _cocktails;

  final List<Wine> _wines = const [
    Wine(
      id: 'barolo',
      name: 'Barolo DOCG',
      producer: 'Marchesi di Barolo',
      region: 'Piemonte',
      grape: 'Nebbiolo',
      type: 'red',
      vintage: '2019',
      priceGlass: 18,
      priceBottle: 85,
      tastingNotes: 'Full-bodied with firm tannins. Notes of dried rose, tar, cherry, and leather. Long, structured finish with earthy minerality.',
      story: 'Called the "King of Italian wines," Barolo is produced in 11 communes in the Langhe hills of Piemonte. Marchesi di Barolo has been crafting this DOCG since 1861, making them one of the oldest producers in the region.',
      pairings: ['Tagliata', 'Aged cheeses', 'Truffle dishes'],
      emoji: '🍷',
    ),
    Wine(
      id: 'barbaresco',
      name: 'Barbaresco DOCG',
      producer: 'Gaja',
      region: 'Piemonte',
      grape: 'Nebbiolo',
      type: 'red',
      vintage: '2020',
      priceGlass: 22,
      priceBottle: 110,
      tastingNotes: 'Elegant and refined with silky tannins. Aromas of violet, cherry, and iron. The "Queen" to Barolo\'s King — more accessible in youth.',
      story: 'Angelo Gaja single-handedly elevated Barbaresco to world-class status in the 1970s by introducing French barriques. Today, Gaja remains the most prestigious name in Piemontese wine.',
      pairings: ['25k Tagliolini', 'Giant Raviolo', 'Tagliata'],
      emoji: '🍷',
    ),
    Wine(
      id: 'chianti',
      name: 'Chianti Classico Riserva',
      producer: 'Castello di Ama',
      region: 'Tuscany',
      grape: 'Sangiovese',
      type: 'red',
      vintage: '2020',
      priceGlass: 15,
      priceBottle: 65,
      tastingNotes: 'Medium-bodied Sangiovese with bright cherry, dried herb, balsamic, and tobacco. Vibrant acidity, classic Chianti structure.',
      story: 'Produced at Castello di Ama in Gaiole in Chianti, one of the DOCG\'s most storied estates. The \'Riserva\' designation means extended aging — minimum 27 months — resulting in greater complexity.',
      pairings: ['Mortadella Board', 'Tagliata', 'Aged Pecorino'],
      emoji: '🍷',
    ),
    Wine(
      id: 'vermentino',
      name: 'Vermentino di Sardegna',
      producer: 'Sella & Mosca',
      region: 'Sardinia',
      grape: 'Vermentino',
      type: 'white',
      vintage: '2023',
      priceGlass: 12,
      priceBottle: 48,
      tastingNotes: 'Crisp and aromatic with lemon zest, white peach, almond, and a saline minerality on the finish. Perfect with seafood.',
      story: 'Sella & Mosca is Sardinia\'s most celebrated winery, founded in 1899 near Alghero. Their Vermentino captures the island\'s sea breeze and Mediterranean herbs in every glass.',
      pairings: ['Burrata', 'Fregola Sarda', 'Branzino'],
      emoji: '🥂',
    ),
    Wine(
      id: 'greco',
      name: 'Greco di Tufo DOCG',
      producer: 'Feudi di San Gregorio',
      region: 'Campania',
      grape: 'Greco',
      type: 'white',
      vintage: '2022',
      priceGlass: 13,
      priceBottle: 52,
      tastingNotes: 'Full-bodied white with volcanic minerality. Aromas of pear, apricot, hazelnut, and flint. Long, mouth-coating finish.',
      story: 'Greco di Tufo is grown in the volcanic soils of Avellino, Campania — a region whose volcanic activity imbues the wine with a distinctive smoky, mineral character. Feudi di San Gregorio is its finest interpreter.',
      pairings: ['Branzino', 'Burrata', 'Arancini'],
      emoji: '🥂',
    ),
    Wine(
      id: 'prosecco',
      name: 'Prosecco Superiore DOCG',
      producer: 'Bisol',
      region: 'Veneto',
      grape: 'Glera',
      type: 'sparkling',
      vintage: 'NV',
      priceGlass: 10,
      priceBottle: 42,
      tastingNotes: 'Fresh and lively with fine bubbles, green apple, white pear, and hints of wisteria. Dry, crisp finish.',
      story: 'Bisol has been producing Prosecco in the Valdobbiadene hills since 1542, making them one of the oldest wine families in the DOCG. Their Superiore is among the benchmark expressions.',
      pairings: ['Burrata', 'Arancini', 'Aperitivo hour'],
      emoji: '🍾',
    ),
    Wine(
      id: 'moscato',
      name: 'Moscato d\'Asti DOCG',
      producer: 'Michele Chiarlo',
      region: 'Piemonte',
      grape: 'Moscato Bianco',
      type: 'sparkling',
      vintage: '2023',
      priceGlass: 11,
      priceBottle: 44,
      tastingNotes: 'Gently sparkling (frizzante) with low alcohol. Intensely aromatic: apricot, peach, orange blossom, and honey.',
      story: 'Moscato d\'Asti is the dessert wine of Piemonte — delicate, low in alcohol (5.5%), and overflowing with stone fruit. Michele Chiarlo\'s "Nivole" bottling is consistently one of Italy\'s most celebrated examples.',
      pairings: ['Pistachio Tiramisu', 'Crostata', 'Profiteroles'],
      emoji: '🍾',
    ),
  ];

  final List<Cocktail> _cocktails = const [
    Cocktail(
      id: 'negroni-sbagliato',
      name: 'Negroni Sbagliato',
      description: 'The "mistaken" Negroni — born when a Milan bartender grabbed Prosecco instead of gin. Lighter, bubblier, and utterly Italian.',
      ingredients: ['Campari', 'Sweet vermouth', 'Prosecco', 'Orange peel'],
      price: 15,
      emoji: '🍊',
    ),
    Cocktail(
      id: 'aperol-spritz',
      name: 'Aperol Spritz',
      description: 'Italy\'s quintessential pre-dinner ritual. Bittersweet Aperol lifted by house Prosecco with a splash of soda and an orange slice.',
      ingredients: ['Aperol', 'Prosecco', 'Soda water', 'Orange slice'],
      price: 13,
      emoji: '🧡',
    ),
    Cocktail(
      id: 'sgroppino',
      name: 'Sgroppino',
      description: 'Venice\'s palate cleanser turned cocktail — lemon sorbet blended with vodka and Prosecco until frothy. Refreshing and theatrical.',
      ingredients: ['Lemon sorbet', 'Vodka', 'Prosecco'],
      price: 14,
      emoji: '🍋',
    ),
    Cocktail(
      id: 'limoncello-mule',
      name: 'Amalfi Mule',
      description: 'House limoncello meets ginger beer over crushed ice. A Southern Italian twist on the Moscow Mule that tastes like the Amalfi coast.',
      ingredients: ['House limoncello', 'Ginger beer', 'Lime juice', 'Mint'],
      price: 14,
      emoji: '🌿',
    ),
    Cocktail(
      id: 'briscola-old-fashioned',
      name: 'Briscola Old Fashioned',
      description: 'Our signature — Amaro Montenegro, grappa, orange bitters, and a hand-carved ice sphere. The card game in a glass.',
      ingredients: ['Amaro Montenegro', 'Grappa', 'Orange bitters', 'Demerara syrup'],
      price: 18,
      emoji: '🃏',
    ),
    Cocktail(
      id: 'bellini',
      name: 'White Peach Bellini',
      description: 'Harry\'s Bar Venice, 1948. White peach purée meets cold Prosecco in the most elegant of combinations.',
      ingredients: ['White peach purée', 'Prosecco'],
      price: 13,
      emoji: '🍑',
    ),
  ];
}
