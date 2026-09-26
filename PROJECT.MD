# Briscola Trattoria Mobile App Concept

This document outlines a Flutter mobile app concept designed specifically for **Briscola Trattoria** in Brooklyn. The app is built around the restaurant's unique identity: exploring regional Italian dishes and house-made pastas, discovering the stories behind signature plates like the giant raviolo and fregola sarda, browsing Italian wines and cocktails, learning the Briscola card game that inspired the restaurant, and managing dessert cart orders, family-style menus, and private events.

---

## 1. Business Details & Essential Links

### 1.1 Core Restaurant Information

| Field | Detail |
|---|---|
| **Name** | Briscola Trattoria |
| **Address** | 798A Franklin Ave, Brooklyn, NY 11238 |
| **Phone** | +1 917-966-2670 |
| **Email** | briscolabrooklyn@gmail.com |
| **Website** | https://briscolabrooklyn.com |
| **Cuisine** | Modern Italian Trattoria (regional Italian, house-made pasta) |
| **Chef** | Silvia Barban (Top Chef alum, from Northern Italy) |
| **Partners** | Luca Pelliccioni, Federico Cesi, Andrea Mancin |
| **Dining Style** | Casual, upscale-casual; price $30 and under |
| **Neighborhood** | Crown Heights, Brooklyn |
| **Hours** | Mon–Thu: 5:30 PM – 9:30 PM · Fri: 5:00 PM – 10:30 PM · Sat: 12:00 PM – 10:30 PM · Sun: 12:00 PM – 9:30 PM |
| **Reservations** | Via Resy; strict 15-minute grace period |
| **Key Highlights** | 25k tagliolini (sweetbread ragù), dessert cart, Italian wine on tap, in-house mortadella |
| **Groups & Private Events** | Custom Italian menus, private dining space, catering available |
| **Website Features** | Online ordering (Toast), catering, groups & private parties, reservations |

---

### 1.2 Complete Link Reference

All external links the app should deep-link to, organized by function.

#### Reservations & Booking

| Purpose | Link |
|---|---|
| **Resy Reservation Page** | https://resy.com/cities/new-york-ny/venues/briscola-trattoria |
| **Resy with Date & Party Size** | https://resy.com/cities/new-york-ny/venues/briscola-trattoria?seats=2&date=2026-09-26 |
| **Resy — San Valentino Event** | https://resy.com/cities/new-york-ny/venues/briscola-trattoria (special event booking) |

#### Online Ordering & Delivery

| Purpose | Link |
|---|---|
| **Toast Online Ordering (Pickup & Delivery)** | https://order.toasttab.com/online/briscola-trattoria-798a-franklin-avenue |
| **Toast — Specific Item (e.g., Arancini)** | https://order.toasttab.com/online/briscola-trattoria-798a-franklin-avenue/item-arancini_14aee978-3914-4e94-9c40-af989873d7fc |
| **DoorDash** | https://www.doordash.com/store/briscola-trattoria-brooklyn- (search "Briscola Trattoria") |
| **Uber Eats** | https://www.ubereats.com/store/briscola-trattoria-798a-franklin-avenue (search "Briscola Trattoria") |

#### Catering & Private Events

| Purpose | Link |
|---|---|
| **Catering Inquiry (via Website)** | https://briscolabrooklyn.com/ (Catering section) |
| **Groups & Private Parties (via Website)** | https://briscolabrooklyn.com/ (Groups & Private Parties section) |
| **Email for Groups (7+ people)** | mailto:briscolabrooklyn@gmail.com |
| **Phone for Events** | tel:+19179662670 |

#### Contact & Location

| Purpose | Link |
|---|---|
| **Google Maps Directions** | https://www.google.com/maps/search/Briscola+Trattoria,798A+Franklin+Ave,Brooklyn,NY,11238 |
| **Phone** | tel:+19179662670 |
| **Email** | mailto:briscolabrooklyn@gmail.com |
| **Accessibility Page** | https://briscolabrooklyn.com/accessibility-page-01 |

#### Social & Reviews

| Purpose | Link |
|---|---|
| **Google Reviews** | https://www.google.com/maps/search/Briscola+Trattoria (Reviews tab) |
| **Yelp** | https://www.yelp.com/biz/briscola-trattoria-brooklyn (search) |
| **Instagram** | (search @briscolabrooklyn) |

#### Card Game & Culture

| Purpose | Link |
|---|---|
| **Briscola Game Rules (Wikipedia)** | https://en.wikipedia.org/wiki/Briscola |
| **Briscola Rules (Pagat)** | https://www.pagat.com/put/briscola.html |

---

## 2. Color Palette

Derived from the restaurant's physical design and branding.

| Role | Color Name | Hex (Approx.) | Usage |
|---|---|---|---|
| **Primary** | Trattoria Red | `#C62828` | App bar, primary buttons, accents |
| **Secondary** | Warm Cream / Ivory | `#F5F0E8` | Backgrounds, cards, surfaces |
| **Accent** | Golden Yellow | `#E6A817` | Highlights, icons, secondary actions |
| **Dark** | Espresso Brown | `#3E2723` | Primary text, headers |
| **Surface** | Soft White | `#FFFFFF` | Cards, modals, input fields |
| **Warm Wood** | Oak / Cognac | `#8D6E63` | Dividers, secondary text, subtle accents |

---

## 3. App Architecture Plan

### 3.1 Project Structure (Flutter)
lib/
├── main.dart
├── app/
│ ├── theme/
│ │ ├── app_colors.dart
│ │ ├── app_text_styles.dart
│ │ └── app_theme.dart
│ ├── routes/
│ │ └── app_router.dart
│ └── constants/
│ └── app_strings.dart
├── models/
│ ├── dish.dart
│ ├── wine.dart
│ ├── cocktail.dart
│ ├── event.dart
│ └── card.dart
├── providers/
│ ├── menu_provider.dart
│ ├── wine_provider.dart
│ ├── event_provider.dart
│ └── game_provider.dart
├── screens/
│ ├── home/
│ ├── menu/
│ │ ├── menu_screen.dart
│ │ ├── dish_detail_screen.dart
│ │ └── story_screen.dart
│ ├── wine_cocktails/
│ │ ├── wine_list_screen.dart
│ │ └── wine_detail_screen.dart
│ ├── briscola_game/
│ │ ├── game_lobby_screen.dart
│ │ ├── game_board_screen.dart
│ │ └── game_tutorial_screen.dart
│ ├── dessert_cart/
│ │ └── dessert_cart_screen.dart
│ ├── events/
│ │ ├── events_screen.dart
│ │ └── event_detail_screen.dart
│ └── reservations/
│ └── reservation_screen.dart
├── widgets/
│ ├── dish_card.dart
│ ├── wine_card.dart
│ ├── playing_card.dart
│ └── section_header.dart
└── services/
├── api_service.dart
├── menu_service.dart
└── reservation_service.dart


### 3.2 Core Modules

#### Menu & Dish Discovery

- **Menu Tab**: Categorized list (Antipasti, Primi, Secondi, Dolci) with dish cards showing name, short description, and price.
- **Dish Detail View**: Full story behind each dish. Tapping "Giant Raviolo" opens a narrative about the dish's regional origins and Chef Barban's interpretation. Includes ingredients, preparation notes, and pairing suggestions.
- **Regional Map View**: Interactive map of Italy highlighting regions tied to specific dishes (e.g., Liguria → Trofie al Pesto, Sardinia → Fregola Sarda).

#### Briscola Card Game

- **Game Lobby**: Choose 1v1 or 2v2. Option to play against an AI opponent or learn the rules.
- **Game Board**: A 40-card Italian deck (no 8s, 9s, 10s). Trump suit revealed at the start. Drag-and-drop card play with trick resolution and point tracking (A=11, 3=10, Re=4, Cavallo=3, Fante=2).
- **Tutorial Mode**: Step-by-step guided tutorial explaining the Briscola and its role as the trump suit.
- **Staff Challenge**: A special mode where guests can challenge the restaurant's staff (in-app leaderboard) after their last seating, mirroring the in-person experience.

#### Wine & Cocktails

- **Wine List**: Filter by region, grape, and type (red, white, sparkling). Each wine has a detail page with tasting notes, pairing recommendations, and the story of the Italian winery.
- **Cocktail Menu**: Signature cocktails with descriptions and ingredient lists.

#### Dessert Cart

- **Dessert Cart Screen**: A visual replica of the restaurant's rotating dessert cart. Guests can browse profiteroles, seasonal crostata, zuppa inglese, and pistachio tiramisu.
- **Pre-Order**: Add desserts to a "cart" for pickup or delivery, syncing with Toast online ordering.

#### Events & Private Dining

- **Events Screen**: Browse catering options, family-style menus, and private event packages.
- **Event Detail**: Custom menu builder for large groups, capacity details, and inquiry form.
- **Reservation Integration**: Deep-link to Resy for table booking.

### 3.3 Technical Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Dart) |
| **State Management** | Provider or Riverpod |
| **Navigation** | GoRouter |
| **Backend / API** | REST API (Node.js or Firebase) for menu, events, and game data |
| **Database** | Firebase Firestore (menu, events) + SQLite (local game state) |
| **Auth** | Firebase Auth (optional, for events and leaderboards) |
| **Reservation** | Deep-link to Resy |
| **Ordering** | Deep-link to Toast online ordering |
| **Game Engine** | Custom Flutter logic with `flutter_animate` for card animations |
| **Assets** | SVG icons, custom Italian card deck illustrations |

### 3.4 Design Principles

- **Warm & Inviting**: Use the Trattoria Red and Warm Cream palette to evoke the restaurant's cozy, retro-modern atmosphere.
- **Story-Driven**: Every dish, wine, and cocktail has a narrative. The app is a guide, not just a menu.
- **Playful but Elegant**: The Briscola game adds a fun, interactive layer without compromising the sophisticated Italian dining experience.
- **Seamless Integration**: Deep-links to Resy for reservations and Toast for ordering keep the experience connected to the restaurant's existing tools.

---

This architecture provides a complete Flutter app concept that captures Briscola's identity — from regional Italian pasta stories to the namesake card game — while keeping the technical structure clean and maintainable.