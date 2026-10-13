# Invest Now — Mobile Investment Experience

A mobile investment application built with Flutter, Dart, and Flutter Riverpod for the Flutter Developer Take-Home Assessment.

The application allows users to explore verified investment products, inspect comprehensive product specifications, simulate returns using a real-time financial calculator, review and confirm orders with idempotency protection, and manage created investment holdings within their portfolio.

---

## 📱 Features

### 1. Investment Products Catalog (Explore)
- **Product Overview**: Displays available financial products with essential metrics:
  - Product Name & Category
  - Expected Return / Interest Rate (e.g., `7.5% p.a.`)
  - Investment Duration (e.g., `30 Days`, `90 Days`, `180 Days`)
  - Minimum Investment Amount (e.g., `$100`, `$250`, `$500`)
  - Risk Level indicator badges (`Low`, `Medium`, `High`)
- **Search & Filtering**:
  - Live text search across product names, categories, and descriptions.
  - Risk level filter chips (`All`, `Low`, `Medium`, `High`).
- **Interactive UX States**:
  - Shimmer loading skeletons during data fetching.
  - Error state with retry action on network/server failures.
  - Empty state with reset filters button when no products match the query.
  - Pull-to-refresh to sync latest product listings.

### 2. Product Details & Live Investment Calculator
- **Full Product Specifications**:
  - Minimum and maximum investment capital limits.
  - Tenure duration in days and formatted labels.
  - Payout frequency (e.g., `At Maturity`).
  - Maturity terms, settlement rules, and full descriptions.
  - Key product highlights and ESG/guarantee verification.
- **Interactive Financial Calculator**:
  - Allows customers to input their custom investment capital.
  - Quick amount increment buttons (`Min`, `+$500`, `+$1,000`, `Max`).
  - Real-time yield and maturity payout projections calculated dynamically.
  - Robust input validation ensuring valid numeric inputs within allowed minimum and maximum constraints.

### 3. Investment Confirmation & Duplicate Prevention
- **Order Summary Breakdown**:
  - Invested capital, annualized return rate, estimated interest yield.
  - Platform/management fee breakdown (`$0.00`).
  - Net total maturity payout.
  - Start date and formatted maturity date.
  - Funding source selection (`Primary Wallet`, `Bank Transfer`).
- **Financial Reliability & Duplicate Prevention**:
  - Unique session-based idempotency keys generated per transaction attempt.
  - Accidental duplicate submission prevention with button locking and loading indicators.
  - Backend integration detects re-submissions and returns existing investments safely.

### 4. Investment Success Confirmation
- Celebration receipt highlighting the unique transaction reference number (e.g., `INV-20261013-XXXXXX`).
- One-tap copy-to-clipboard functionality with feedback toast.
- Duplicate prevention banner if an idempotency match was safely handled.
- Quick navigation to view holdings in the Portfolio or explore more opportunities.

### 5. Portfolio & Holdings Management (Profile Tab)
- Real-time portfolio totals:
  - Total Capital Invested
  - Total Estimated Returns
  - Total Portfolio Maturity Value
  - Active Holdings Count
- Detailed list of user-created investments.
- Interactive Investment Certificate bottom sheet detailing reference numbers, timestamps, and maturity terms.
- Built-in **Assessment Testing Controls**: A quick settings sheet allowing evaluators to simulate server errors (`500`), empty portfolios, and server reset triggers directly from the device.

---

## 🏗️ Architecture & Project Structure

The project follows clean architecture principles with a strict separation between **Presentation (UI)**, **State & Business Logic (Controllers)**, and **Data Access (Repositories & Services)**.

```
lib/
├── api/
│   ├── interfaces/          # Abstract contracts (InvestmentsInterface, ProductsInterface, NetworkApi)
│   ├── keys/                # API endpoints and baseUrl configuration
│   ├── Models/              # Strongly-typed data models (Products, Investments, Previews, Errors)
│   ├── repositories/        # Repository implementations mapping network calls to domain entities
│   ├── services/            # Low-level network client (Dio, interceptors, smart retry)
│   └── utils/               # NetworkResponse wrapper and logger
├── core/
│   ├── Alerts/              # Snackbars and global navigation keys
│   ├── Controllers/         # StateNotifier (UserController) and immutable AppState
│   ├── Extensions/          # UI and Dart extension helpers
│   └── Utilities/
│       ├── Calculators/     # Pure financial math (InvestmentCalculator)
│       ├── Enums/           # RiskLevel and other domain enums
│       ├── routes/          # GoRouter configuration with nested shell navigation
│       ├── Transitions/     # Page transition animations (iOS slide transitions)
│       └── Validators/      # Input and amount validation (InvestmentValidator)
└── presentation/
    ├── styles/              # Theme, colors, typography, dark mode provider
    └── views/
        ├── Home/            # Home screen, product details, confirmation, success screens
        │   ├── ui/          # Pages and screens
        │   └── widgets/     # Reusable product cards and calculation widgets
        ├── Profile/         # User portfolio and holdings view
        │   ├── ui/          # ProfilePage
        │   └── widgets/     # InvestmentCardWidget, InvestmentDetailsBottomSheet
        └── components/      # Shared buttons, badges, shimmer skeletons, and app bars
```

### State Management
- Utilizes **Flutter Riverpod** (`StateNotifierProvider`).
- `UserController` manages application state, orchestrating calls between `ProductsInterface` and `InvestmentsInterface`.
- `AppState` is an immutable state model equipped with computed getters (`filteredProducts`, `totalInvested`, `totalExpectedReturns`, `totalPortfolioValue`, `activeInvestmentsCount`).

---

## 🧮 Financial Calculations & Assumptions

1. **Simple Interest Formula**:
   $$\text{Estimated Earnings} = \text{Principal} \times \left(\frac{\text{Annual Interest Rate}}{100}\right) \times \left(\frac{\text{Duration in Days}}{365}\right)$$
   Values are rounded to 2 decimal places to adhere to standard currency accounting.
2. **Total Payout at Maturity**:
   $$\text{Total Payout} = \text{Principal} + \text{Estimated Earnings}$$
3. **Idempotency**:
   Every creation request carries an `idempotencyKey`. If a network glitch causes a retry or accidental re-submission, the server identifies the idempotency key, prevents multiple charges, and returns the existing investment record with `wasDuplicatePrevented: true`.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>= 3.0.0)
- [.NET SDK](https://dotnet.microsoft.com/download) (for running the mock REST API backend)

### 1. Start the Mock API Backend
In the backend repository directory:
```bash
dotnet run --project investmentSimuoation.csproj
```
The server will run at `http://localhost:5140`.

*Note for Android Emulators: The app automatically maps `http://10.0.2.2:5140` when running on Android via `ApiKeys.baseUrl`.*

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Run Static Code Analysis
```bash
flutter analyze
```

### 4. Run the Mobile Application
```bash
flutter run
```

---

## 🧪 Running Unit & Integration Tests

The project includes unit test suites validating financial calculations, input validation, state management, and repository integration:

```bash
# Run all unit and integration tests
flutter test

# Run individual test suites:
flutter test test/investment_calculator_test.dart
flutter test test/investment_validator_test.dart
flutter test test/app_state_test.dart
flutter test test/api_repositories_test.dart
```

### Test Coverage Highlights:
- **`investment_calculator_test.dart`**: Verifies simple interest calculations across 30, 90, 180, and 365-day tenures, negative/zero edge cases, total maturity summation, and currency formatting.
- **`investment_validator_test.dart`**: Validates non-numeric sanitization, negative numbers, minimum capital boundaries, maximum capital boundaries, and comma-separated inputs.
- **`app_state_test.dart`**: Tests risk level filters, search query filtering, and portfolio aggregate calculations (`totalInvested`, `totalExpectedReturns`).
- **`api_repositories_test.dart`**: Tests live backend communication for products, previews, investment creation, duplicate prevention, and error simulation.

---

## 🛡️ Error & Edge Case Handling

- **Graceful Network Retries**: Configured with `dio_smart_retry` to automatically handle transient server drops.
- **Duplicate Prevention**: Buttons are disabled during ongoing network calls, and duplicate submissions are caught safely via idempotency tokens.
- **Friendly Validation**: Instant inline feedback ensures the user is aware of minimum investment requirements before proceeding.
- **Interactive Evaluation Sheet**: Located via the settings icon on the Portfolio page, enabling examiners to test `Simulate Server Error (500)`, `Simulate Empty State`, and `Reset Mock Server Data` with a single tap.
