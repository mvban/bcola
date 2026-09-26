import 'package:flutter/foundation.dart';
import '../models/dish.dart';

class MenuProvider extends ChangeNotifier {
  String _selectedCategory = 'Tutti';

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<String> get categories => ['Tutti', 'Antipasti', 'Primi', 'Secondi', 'Dolci'];

  List<Dish> get allDishes => _dishes;

  List<Dish> get filteredDishes {
    if (_selectedCategory == 'Tutti') return _dishes;
    return _dishes.where((d) => d.category == _selectedCategory).toList();
  }

  final List<Dish> _dishes = const [
    // ANTIPASTI
    Dish(
      id: 'arancini',
      name: 'Arancini di Riso',
      italianName: 'Arancini',
      category: 'Antipasti',
      description: 'Golden saffron rice balls with ragù & mozzarella, crispy breadcrumb crust.',
      story: 'Born in Sicily, arancini (meaning "little oranges") have been street food since the 10th century. Chef Barban fills ours with a slow-braised beef ragù and pulls of fresh fior di latte mozzarella, then rolls them in seasoned breadcrumbs imported from Palermo. Each bite collapses into a warm, molten center.',
      price: 14,
      region: 'Sicily',
      regionEmoji: '🇮🇹',
      ingredients: ['Carnaroli rice', 'Saffron', 'Beef ragù', 'Mozzarella', 'Parmesan', 'Breadcrumbs'],
      pairingSuggestion: 'Pair with a glass of Nero d\'Avola or our house Aperol Spritz.',
      isSignature: false,
      emoji: '🍊',
    ),
    Dish(
      id: 'mortadella',
      name: 'House Mortadella Board',
      italianName: 'Mortadella della Casa',
      category: 'Antipasti',
      description: 'In-house crafted mortadella with pistachios, served with focaccia and mostarda.',
      story: 'Briscola makes its mortadella in-house — a rarity even in Bologna, its hometown. Chef Barban grinds pork shoulder with back fat, seasons it with myrtle berries and white pepper, studded with whole Sicilian pistachios. It\'s steam-cooked slowly for 8 hours, sliced thin, and served on a wooden board with house-made mostarda.',
      price: 18,
      region: 'Emilia-Romagna',
      regionEmoji: '🐷',
      ingredients: ['Pork shoulder', 'Back fat', 'Pistachios', 'Myrtle berries', 'White pepper', 'Focaccia'],
      pairingSuggestion: 'A chilled glass of Lambrusco di Sorbara cuts through the richness perfectly.',
      isSignature: true,
      emoji: '🥩',
    ),
    Dish(
      id: 'burrata',
      name: 'Burrata con Pomodoro',
      italianName: 'Burrata & Pomodoro',
      category: 'Antipasti',
      description: 'Creamy burrata, heirloom tomatoes, basil oil, aged balsamic, Pugliese sea salt.',
      story: 'Burrata originated in Puglia in the 1950s, invented by Lorenzo Bianchino who used scraps of mozzarella curd to create the cream-filled shell. We source ours daily from a small dairy in Bitritto, Bari. Served with heirloom tomatoes sourced from Upstate New York and a 25-year aged balsamic from Modena.',
      price: 16,
      region: 'Puglia',
      regionEmoji: '🫙',
      ingredients: ['Burrata', 'Heirloom tomatoes', 'Basil oil', 'Aged balsamic', 'Fleur de sel'],
      pairingSuggestion: 'Vermentino di Sardegna — crisp acidity cuts the cream beautifully.',
      isSignature: false,
      emoji: '🧀',
    ),

    // PRIMI
    Dish(
      id: 'tagliolini',
      name: '25k Tagliolini',
      italianName: 'Tagliolini al Ragù di Animelle',
      category: 'Primi',
      description: 'Hand-cut tagliolini with a slow-braised sweetbread ragù and black truffle.',
      story: 'Named after the Instagram milestone that made it famous, this dish is Chef Barban\'s most personal creation. The tagliolini are cut by hand every morning — thinner than a credit card — and draped over a ragù of veal sweetbreads braised for six hours in white wine, herbs, and stock. A shaving of black truffle finishes each plate. It\'s the dish that made Briscola a Brooklyn pilgrimage.',
      price: 28,
      region: 'Piemonte',
      regionEmoji: '🖤',
      ingredients: ['Egg tagliolini', 'Veal sweetbreads', 'White wine', 'Shallots', 'Black truffle', 'Butter'],
      pairingSuggestion: 'Barolo or Barbaresco — the Nebbiolo tannins pair magnificently with truffle.',
      isSignature: true,
      emoji: '🍝',
    ),
    Dish(
      id: 'giant-raviolo',
      name: 'Il Grande Raviolo',
      italianName: 'Grande Raviolo all\'Uovo',
      category: 'Primi',
      description: 'A single giant raviolo hiding a runny egg yolk in ricotta, showered with brown butter & sage.',
      story: 'This single, palm-sized raviolo is the most theatrical dish on the menu. A thin sheet of egg pasta is folded over a mound of house-made ricotta, spinach, and nutmeg, with a raw egg yolk nestled in the center. Cooked to order for exactly 3 minutes, it arrives glistening with brown butter and crispy fried sage. Cut it open at the table.',
      price: 24,
      region: 'Emilia-Romagna',
      regionEmoji: '🥚',
      ingredients: ['Egg pasta', 'Ricotta', 'Spinach', 'Egg yolk', 'Brown butter', 'Sage', 'Parmigiano'],
      pairingSuggestion: 'Pignoletto Frizzante — the gentle bubbles cleanse the richness of the yolk.',
      isSignature: true,
      emoji: '🫓',
    ),
    Dish(
      id: 'fregola',
      name: 'Fregola Sarda',
      italianName: 'Fregola con Vongole',
      category: 'Primi',
      description: 'Toasted Sardinian fregola with manila clams, bottarga, chili, and white wine.',
      story: 'Fregola is Sardinia\'s answer to couscous — hand-rolled semolina toasted in a wood oven until golden. Ours is cooked risotto-style in a clam broth with white wine, finished with freshly shaved bottarga (dried mullet roe) and a thread of Calabrian chili oil. The result: deeply savory, briny, and surprisingly comforting.',
      price: 26,
      region: 'Sardinia',
      regionEmoji: '🐚',
      ingredients: ['Fregola sarda', 'Manila clams', 'Bottarga', 'White wine', 'Chili', 'Parsley'],
      pairingSuggestion: 'Vermentino di Gallura — a Sardinian wine for a Sardinian pasta.',
      isSignature: false,
      emoji: '🦪',
    ),
    Dish(
      id: 'trofie',
      name: 'Trofie al Pesto',
      italianName: 'Trofie al Pesto Genovese',
      category: 'Primi',
      description: 'Hand-rolled Ligurian trofie with classic Genovese pesto, green beans, and potatoes.',
      story: 'The trofie shape was invented in Recco, Liguria, to catch and hold the silky basil pesto. Pesto Genovese — recognized as a protected recipe — calls for DOP Ligurian basil, Ligurian extra-virgin olive oil, Parmigiano, Pecorino Sardo, pine nuts, and garlic. We follow the classic recipe religiously, adding sliced green beans and fingerling potatoes boiled right in the pasta water.',
      price: 22,
      region: 'Liguria',
      regionEmoji: '🌿',
      ingredients: ['Trofie pasta', 'DOP basil', 'Pine nuts', 'Parmigiano', 'Pecorino', 'Green beans', 'Potato'],
      pairingSuggestion: 'Pigato from Riviera Ligure di Ponente — grassy, mineral, and perfect.',
      isSignature: false,
      emoji: '💚',
    ),

    // SECONDI
    Dish(
      id: 'branzino',
      name: 'Branzino al Sale',
      italianName: 'Branzino al Sale con Salsa Verde',
      category: 'Secondi',
      description: 'Whole Mediterranean sea bass baked in a salt crust, broken tableside with salsa verde.',
      story: 'Salt-baking is one of Italy\'s oldest cooking methods, sealing moisture and flavors inside an impenetrable crust. We pack the branzino with lemon, fennel fronds, and thyme before encasing it in coarse sea salt. The crust is cracked tableside in a moment of drama, releasing a cloud of fragrant steam. The fish is served with Chef Barban\'s bright salsa verde of capers, anchovies, and parsley.',
      price: 32,
      region: 'Mediterranean',
      regionEmoji: '🐟',
      ingredients: ['Branzino', 'Sea salt', 'Lemon', 'Fennel', 'Capers', 'Anchovies', 'Parsley'],
      pairingSuggestion: 'Greco di Tufo — volcanic minerality matches the sea.',
      isSignature: false,
      emoji: '🐠',
    ),
    Dish(
      id: 'tagliata',
      name: 'Tagliata di Manzo',
      italianName: 'Tagliata con Rucola e Parmigiano',
      category: 'Secondi',
      description: 'Grilled grass-fed strip loin, sliced thin, rucola, shaved Parmigiano, lemon dressing.',
      story: 'The tagliata is Tuscany\'s steakhouse — sliced after resting to expose the blushing interior. We use a grass-fed New York strip from a farm in the Hudson Valley, rubbed with rosemary, crushed garlic, and coarse salt, seared in a cast iron at maximum heat. Sliced at an angle and draped over a cloud of peppery rucola, finished with shaved Parmigiano-Reggiano and a squeeze of Sicilian lemon.',
      price: 38,
      region: 'Tuscany',
      regionEmoji: '🥩',
      ingredients: ['Grass-fed strip loin', 'Rucola', 'Parmigiano-Reggiano', 'Lemon', 'Rosemary', 'Garlic'],
      pairingSuggestion: 'Brunello di Montalcino or Chianti Classico Riserva.',
      isSignature: false,
      emoji: '🥩',
    ),

    // DOLCI
    Dish(
      id: 'tiramisu',
      name: 'Pistachio Tiramisu',
      italianName: 'Tiramisù al Pistacchio',
      category: 'Dolci',
      description: 'Deconstructed tiramisù with pistachio cream, espresso-soaked savoiardi, mascarpone.',
      story: 'While the original tiramisù hails from Treviso, Veneto, this version nods to Sicily\'s obsession with pistachio. Savoiardi from Turin are soaked in a double espresso shot spiked with Amaretto, then layered with whipped mascarpone and a pistachio cream made with DOP Bronte pistachios. A dusting of unsweetened cocoa completes the dessert that arrives on our famous rolling cart.',
      price: 13,
      region: 'Veneto × Sicily',
      regionEmoji: '🍵',
      ingredients: ['Mascarpone', 'Savoiardi', 'Pistachio cream', 'Espresso', 'Amaretto', 'Cocoa'],
      pairingSuggestion: 'Moscato d\'Asti — gentle sweetness and apricot aromas.',
      isSignature: true,
      emoji: '🟢',
    ),
    Dish(
      id: 'profiteroles',
      name: 'Profiteroles al Cioccolato',
      italianName: 'Profiteroles',
      category: 'Dolci',
      description: 'Choux puffs filled with vanilla gelato, drenched in warm dark chocolate sauce.',
      story: 'Profiteroles arrived in Italy from France in the Renaissance, carried north to Florence by Catherine de\' Medici\'s cooks. Our version — a staple of the dessert cart — uses Valrhona 70% dark chocolate ganache poured warm at the table over choux filled with house-made fior di latte gelato. Simple, theatrical, and impossible to share.',
      price: 12,
      region: 'Toscana (via France)',
      regionEmoji: '🍫',
      ingredients: ['Choux pastry', 'Valrhona chocolate', 'Vanilla gelato', 'Cream', 'Butter'],
      pairingSuggestion: 'Brachetto d\'Acqui — sparkling red with raspberry notes.',
      isSignature: false,
      emoji: '⚪',
    ),
    Dish(
      id: 'crostata',
      name: 'Crostata di Stagione',
      italianName: 'Crostata',
      category: 'Dolci',
      description: 'Seasonal rustic tart with pastry cream, rotating local fruit, honey, almonds.',
      story: 'The crostata changes every week with whatever looks best at the farmers\' market in Crown Heights. The shell is a classic pasta frolla — butter, sugar, eggs, and 00 flour — blind-baked until golden. A thick layer of pastry cream (crema pasticciera) goes down first, then the season\'s fruit: cherry in summer, fig in fall, blood orange in winter.',
      price: 11,
      region: 'Pan-Italian',
      regionEmoji: '🥧',
      ingredients: ['Pasta frolla', 'Pastry cream', 'Seasonal fruit', 'Honey', 'Almonds'],
      pairingSuggestion: 'Vin Santo from Tuscany — notes of dried fig and walnut.',
      isSignature: false,
      emoji: '🥧',
    ),
  ];
}
