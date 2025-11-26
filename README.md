# Medical Appointment App - Clean Architecture

O aplicație Flutter pentru gestionarea programărilor medicale, construită folosind **Clean Architecture** cu separare clară pe 3 layer-e: Domain, Data și Presentation.

## 🏗️ Arhitectură

Acest proiect implementează **Clean Architecture** conform principiilor Uncle Bob, oferind:

- ✅ **Separarea responsabilităților** - fiecare layer are un scop bine definit
- ✅ **Testabilitate ridicată** - layerele pot fi testate independent
- ✅ **Scalabilitate** - ușor de adăugat noi funcționalități
- ✅ **Independență de framework** - business logic-ul nu depinde de Flutter
- ✅ **Mentenabilitate** - cod organizat și ușor de înțeles

### Structura Proiectului

```
lib/
├── core/                    # Core utilities și DI
│   └── di/
│       └── dependency_injection.dart
├── domain/                  # Business Logic Layer (Independent)
│   ├── entities/           # Pure business objects
│   ├── repositories/       # Repository interfaces
│   └── usecases/          # Business use cases
├── data/                   # Data Layer (Implementation)
│   ├── models/            # DTOs cu mappers
│   ├── datasources/       # API, Local DB, Mock data
│   └── repositories/      # Repository implementations
└── presentation/          # Presentation Layer (UI)
    ├── controllers/       # State management (GetX)
    ├── screens/          # UI screens
    ├── widgets/          # Reusable components
    ├── theme/            # App theme
    └── utils/            # UI utilities
```

## 📚 Documentație

Pentru detalii complete despre arhitectură și cum să extinzi proiectul:

- 📖 **[CLEAN_ARCHITECTURE.md](CLEAN_ARCHITECTURE.md)** - Explicație detaliată a structurii
- 📊 **[ARCHITECTURE_DIAGRAMS.md](ARCHITECTURE_DIAGRAMS.md)** - Diagrame vizuale
- 💡 **[PRACTICAL_EXAMPLES.md](PRACTICAL_EXAMPLES.md)** - Exemple de cod pentru feature-uri noi
- 🔄 **[BEFORE_AFTER_COMPARISON.md](BEFORE_AFTER_COMPARISON.md)** - Comparație înainte/după
- 🚀 **[NEXT_STEPS.md](NEXT_STEPS.md)** - Pașii următori pentru dezvoltare

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK (3.0+)

### Instalare

```bash
# Clone repository
git clone <repository-url>
cd pam-lab2-lab3

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 🏃‍♂️ Cum Rulează Aplicația

1. **Dependency Injection** este inițializat în `main.dart`:
   ```dart
   void main() {
     DependencyInjection.init();  // Initialize all dependencies
     runApp(const MyApp());
   }
   ```

2. **Controllers** sunt injectate automat când sunt solicitate:
   ```dart
   final controller = Get.find<SpecialistsController>();
   ```

3. **Data flow**:
   ```
   UI → Controller → Use Case → Repository → Data Source → Data
   ```

## 🎯 Funcționalități Actuale

- ✅ Vizualizare listă specialiști medicali
- ✅ Detalii specialist (experiență, rating, disponibilitate)
- ✅ Vizualizare specialități medicale
- ✅ Profil utilizator
- ✅ Calendar disponibilități
- ✅ Selecție slot programare

## 🔨 Tehnologii Folosite

- **Flutter** - UI Framework
- **GetX** - State Management & Dependency Injection
- **Clean Architecture** - Project Structure
- **JSON** - Mock Data (ready for API integration)

## 📦 Packages Principale

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5           # State management & DI
  cupertino_icons: ^1.0.8
```

## 🧪 Testing

Pentru a rula testele:

```bash
flutter test
```

### Strategie de Testare

```
Testing Pyramid:
├─ Unit Tests (Domain & Data layers) - 70%
├─ Widget Tests (Presentation layer) - 20%
└─ Integration Tests (E2E) - 10%
```

Consultă **[NEXT_STEPS.md](NEXT_STEPS.md)** pentru exemple de teste.

## 🎨 Theme

Aplicația folosește Material Design 3 cu o paletă de culori medicală:

- **Primary**: `#357A7B` (Teal)
- **Secondary**: `#767680` (Gray)
- **Background**: White
- **Font**: Lexend

## 📱 Screenshots

*(Adaugă screenshots aici când sunt disponibile)*

## 🔧 Development

### Adăugare Feature Nou

Vezi **[PRACTICAL_EXAMPLES.md](PRACTICAL_EXAMPLES.md)** pentru ghid pas-cu-pas.

Procesul general:
1. Creează **Entities** în `domain/entities/`
2. Definește **Repository Interface** în `domain/repositories/`
3. Creează **Use Cases** în `domain/usecases/`
4. Implementează **Models** în `data/models/`
5. Implementează **Data Sources** în `data/datasources/`
6. Implementează **Repository** în `data/repositories/`
7. Creează **Controller** în `presentation/controllers/`
8. Creează **UI** în `presentation/screens/` sau `widgets/`
9. Configurează **DI** în `core/di/dependency_injection.dart`

### Code Style

- Folosește `dart format` pentru formatare
- Respectă principiile SOLID
- Scrie teste pentru fiecare layer
- Documentează funcțiile complexe

## 🛣️ Roadmap

- [ ] Implementare autentificare utilizator
- [ ] Conectare la API real
- [ ] Sistem de programări complete
- [ ] Notificări push
- [ ] Istoric programări
- [ ] Favorite doctors
- [ ] Search & filters
- [ ] Multi-language support

Vezi **[NEXT_STEPS.md](NEXT_STEPS.md)** pentru detalii complete.

## 📄 License

MIT License - vezi fișierul LICENSE pentru detalii.

## 👥 Contributors

- Misa - Initial Clean Architecture implementation

## 🤝 Contributing

Pull requests sunt binevenite! Pentru schimbări majore, te rugăm să deschizi mai întâi un issue pentru a discuta ce ai dori să modifici.

## 📞 Contact

Pentru întrebări sau sugestii, deschide un issue pe GitHub.

---

**Built with ❤️ using Flutter & Clean Architecture**
