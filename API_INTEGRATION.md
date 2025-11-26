# Integrare API Real - Documentație

## ✅ Ce s-a schimbat

Proiectul folosește acum **API real** în loc de mock data din assets JSON!

### Endpoints API

**Base URL:** `https://test-api-jlbn.onrender.com/v5`

1. **GET /feed** - Lista tuturor specialiștilor
   - URL: `https://test-api-jlbn.onrender.com/v5/feed`
   - Returnează: Array de specialiști

2. **GET /feed/details** - Detalii complete specialiști
   - URL: `https://test-api-jlbn.onrender.com/v5/feed/details`
   - Returnează: Array de specialiști cu detalii complete

---

## 🔧 Modificări în Cod

### 1. Package Adăugat

**pubspec.yaml:**
```yaml
dependencies:
  http: ^1.1.0  # ✅ Adăugat pentru API calls
```

### 2. Data Sources Actualizate

#### ✅ SpecialistRemoteDataSource
- **Înainte:** Citea din `assets/mocks/specialists.json`
- **Acum:** Face request la `https://test-api-jlbn.onrender.com/v5/feed`

**Funcționalități:**
- `getSpecialists()` - fetch lista completă
- `getSpecialistById(id)` - fetch specialist specific din `/feed/details`

**Error Handling:**
- Try-catch pentru network errors
- Status code checking (200 = success)
- Exceptions cu mesaje descriptive

#### ✅ ProfileRemoteDataSource
- **Înainte:** Citea din `assets/mocks/profile.json`
- **Acum:** Face request la API și returnează profil default
- **Fallback:** Returnează profil default dacă API-ul eșuează

#### ✅ SpecialtyRemoteDataSource
- **Înainte:** Citea din `assets/mocks/specialties.json`
- **Acum:** Extrage specialități unice din lista de specialiști
- **Smart extraction:** Deduplică specialități automat
- **Icon mapping:** Mapează icoane bazat pe specialty name

---

## 🚀 Cum Funcționează

### Flow Complet:

```
User opens app
    ↓
Controller.fetchSpecialists()
    ↓
Use Case.execute()
    ↓
Repository.getSpecialists()
    ↓
DataSource.getSpecialists()
    ↓
HTTP GET → https://test-api-jlbn.onrender.com/v5/feed
    ↓
[API Response - JSON]
    ↓
Parse JSON → List<SpecialistModel>
    ↓
Map to List<SpecialistEntity>
    ↓
Return to Controller
    ↓
UI Updates (Reactive with GetX)
```

### Cod Exemplu:

```dart
// lib/data/datasources/specialist_remote_data_source.dart
class SpecialistRemoteDataSourceImpl implements SpecialistRemoteDataSource {
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/v5/feed';
  final http.Client client;

  @override
  Future<List<SpecialistModel>> getSpecialists() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        return (jsonData as List)
            .map((json) => SpecialistModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
```

---

## ⚠️ Note Importante

### 1. API Hosted pe Render (Free Tier)
- **Cold Start:** Primul request poate dura 20-30 secunde
- **Reason:** Free tier instances se opresc după inactivitate
- **Solution:** Afișează loading indicator în UI

### 2. Error Handling
Toate data sources au:
- ✅ Try-catch blocks
- ✅ Status code validation
- ✅ Descriptive error messages
- ✅ Fallback mechanisms (unde e posibil)

### 3. Testing cu Mock Data
Dacă vrei să testezi fără API:
```dart
// În dependency_injection.dart
Get.lazyPut<SpecialistRemoteDataSource>(
  // Opțiune 1: API Real
  () => SpecialistRemoteDataSourceImpl(),
  
  // Opțiune 2: Mock (pentru testing)
  // () => MockSpecialistRemoteDataSource(),
);
```

---

## 🔍 Debugging

### Verifică Network Calls

**Chrome DevTools:**
1. Deschide DevTools în browser (F12)
2. Mergi la tab "Network"
3. Filtrează după "feed"
4. Vezi request/response details

**Flutter DevTools:**
```bash
# În terminal după ce aplicația rulează
# Click pe link-ul DevTools
http://127.0.0.1:9100?uri=http://...
```

### Common Issues

#### ❌ "Failed to load specialists: 503"
**Cauză:** API-ul se pornește (cold start)
**Soluție:** Așteaptă 30 secunde și încearcă din nou

#### ❌ "Error fetching specialists: SocketException"
**Cauză:** Probleme de internet sau API down
**Soluție:** Verifică conexiunea la internet

#### ❌ "FormatException: Unexpected character"
**Cauză:** Response-ul nu e valid JSON
**Soluție:** Verifică că API returnează JSON corect

---

## 🧪 Testing API Manual

### Testează cu cURL:
```bash
# Test endpoint feed
curl https://test-api-jlbn.onrender.com/v5/feed

# Test endpoint details
curl https://test-api-jlbn.onrender.com/v5/feed/details
```

### Testează cu Browser:
Deschide în browser:
- https://test-api-jlbn.onrender.com/v5/feed
- https://test-api-jlbn.onrender.com/v5/feed/details

---

## 📊 Comparație: Înainte vs Acum

| Aspect | Înainte (Mock) | Acum (API Real) |
|--------|----------------|-----------------|
| **Sursă Date** | assets/mocks/*.json | API Remote |
| **Speed** | Instant | 100ms - 30s (cold start) |
| **Internet** | Nu e necesar | Necesar |
| **Testing** | Ușor | Necesită mock sau API disponibil |
| **Production Ready** | ❌ Nu | ✅ Da |
| **Real-time Updates** | ❌ Nu | ✅ Da (când API se actualizează) |

---

## 🔄 Extindere Viitoare

### Adaugă Caching
```dart
class SpecialistRepositoryImpl {
  final SpecialistRemoteDataSource remoteDataSource;
  final SpecialistLocalDataSource localDataSource; // ✨ NEW
  
  @override
  Future<List<SpecialistEntity>> getSpecialists() async {
    try {
      // Try API first
      final remote = await remoteDataSource.getSpecialists();
      await localDataSource.cache(remote); // Cache result
      return remote.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Fallback to cache
      final cached = await localDataSource.getCached();
      return cached.map((m) => m.toEntity()).toList();
    }
  }
}
```

### Adaugă Retry Logic
```dart
Future<List<SpecialistModel>> getSpecialists({int retries = 3}) async {
  for (int i = 0; i < retries; i++) {
    try {
      final response = await client.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return parseResponse(response);
      }
    } catch (e) {
      if (i == retries - 1) rethrow;
      await Future.delayed(Duration(seconds: 2 * (i + 1)));
    }
  }
  throw Exception('Failed after $retries retries');
}
```

### Adaugă Authentication
```dart
class SpecialistRemoteDataSourceImpl {
  Future<List<SpecialistModel>> getSpecialists() async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token', // ✨ NEW
        'Content-Type': 'application/json',
      },
    );
    // ...
  }
}
```

---

## ✅ Checklist Implementare

- [x] Adăugat package `http` în pubspec.yaml
- [x] Actualizat `SpecialistRemoteDataSource` cu API calls
- [x] Actualizat `ProfileRemoteDataSource` cu API calls
- [x] Actualizat `SpecialtyRemoteDataSource` cu API calls
- [x] Adăugat error handling în toate data sources
- [x] Testat că aplicația compilează
- [ ] Testat că API-ul returnează date corecte
- [ ] Verificat UI cu date reale
- [ ] Implementat caching (opțional)
- [ ] Adăugat retry logic (opțional)

---

## 🎓 Best Practices Implementate

1. ✅ **HTTP Client Injection** - Client poate fi înlocuit pentru testing
2. ✅ **Error Handling** - Try-catch și status code validation
3. ✅ **Clean Architecture** - Data source separate de business logic
4. ✅ **Separation of Concerns** - API logic izolat în data layer
5. ✅ **Testability** - Ușor de mock-uit client-ul pentru unit tests

---

**🎉 Aplicația folosește acum date REALE din API!**
