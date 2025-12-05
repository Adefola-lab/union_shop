# Union Shop - Flutter E-Commerce Application

A fully functional e-commerce application built with Flutter, recreating the University of Portsmouth Union Shop with modern mobile and desktop responsive design.

## 🚀 Features

### Core Functionality

#### 🏠 Home Page
- Interactive image carousel with auto-rotating product showcases
- Multiple product sections (Featured Products, New Arrivals, Sale Items)
- Responsive grid layouts adapting to screen sizes
- Navigation to product details and collections
- Dynamic product cards with images, names, and prices

#### 🛒 Shopping Cart System
- Add products to cart with variant selection (size, color)
- View cart with product details and thumbnails
- Update quantities or remove items
- Real-time price calculations (subtotal, tax, total)
- Checkout functionality with order confirmation
- Cart badge showing item count in navigation
- Persistent cart state across navigation

#### 🔐 Authentication System
- Email/password sign-up and sign-in
- Google authentication integration
- Facebook authentication integration
- Sign-out functionality
- User profile management
- Display name update capability
- Account dashboard with user information

#### 👤 Account Management
- User profile display with avatar and name
- Order history section (TODO: implementation pending)
- Settings management (TODO: implementation pending)
- Addresses management (TODO: implementation pending)
- Payment methods (TODO: implementation pending)

#### 🎨 Text Personalization
- Custom text printing service (Print Shack)
- Dynamic pricing: £3 for 1 line, £5 for 2 lines
- Character limit validation (10 characters per line)
- Form validation with real-time feedback
- Add personalized items to cart
- Dedicated Print Shack about page

#### 🔍 Search Functionality
- Real-time product search
- Case-insensitive filtering
- Search results display with product cards
- Navigate from search results to product pages

#### 📦 Product Pages
- Detailed product information
- Multiple product images
- Size and color variant selection
- Quantity selector
- Add to cart with selected variants
- Price display with sale prices
- Product descriptions

#### 🗂️ Collections
- Collections landing page with multiple collections
- Individual collection pages with product filtering
- Sort by price, name, or date
- Filter by category, size, color
- Responsive collection grids
- Collection-specific product displays

#### ℹ️ Information Pages
- About Us page with company information
- Print Shack about page with service details
- Footer with navigation links

### 📱 Responsive Design
- Mobile-first approach (320px - 600px)
- Tablet optimization (600px - 900px)
- Desktop support (900px+)
- Adaptive navigation (drawer on mobile, bar on desktop)
- Flexible grid layouts adjusting to screen width
- Responsive typography and spacing

## 🏗️ Architecture

### State Management
- **ChangeNotifier Pattern**: Used for cart and authentication services
- **Singleton Services**: CartService and AuthService for global state
- **Provider Pattern Ready**: Structure supports Provider integration

### Project Structure

lib/
├── main.dart # App entry point, home screen, navigation
├── models/
│ ├── cart_item.dart # Cart item data model
│ └── product.dart # Product data model
├── services/
│ ├── auth_service.dart # Authentication management
│ ├── cart_service.dart # Shopping cart management
│ └── product_service.dart # Product data (in-memory)
├── about_us.dart # Company information page
├── account_page.dart # User account dashboard
├── cart_page.dart # Shopping cart UI
├── collection.dart # Individual collection page
├── collections_landing.dart # Collections overview page
├── personalisation_page.dart # Text customization page
├── print_shack_about.dart # Print service information
├── product_page.dart # Product detail page
├── search_page.dart # Search functionality
└── sign_in.dart # Authentication UI

test/
├── widget_test.dart # Home page widget tests
├── cart_test.dart # Cart service and UI tests
├── auth_test.dart # Authentication tests
├── search_test.dart # Search functionality tests
├── personalisation_test.dart # Personalization tests
├── collection_test.dart # Collection page tests
└── integration_test.dart # End-to-end user flow tests

### Data Models

#### Product
- `id`: Unique identifier
- `name`: Product name
- `price`: Current price
- `originalPrice`: Pre-discount price (optional)
- `imageUrl`: Product image URL
- `description`: Product description
- `category`: Product category
- `sizes`: Available sizes
- `colors`: Available colors

#### CartItem
- `product`: Product reference
- `quantity`: Item quantity
- `size`: Selected size (optional)
- `color`: Selected color (optional)

#### User
- `uid`: User ID
- `email`: User email
- `displayName`: User display name

### Services

#### CartService
- **Singleton pattern** for global cart state
- `addItem()`: Add product to cart with variants
- `removeItem()`: Remove product from cart
- `updateQuantity()`: Change item quantity
- `clearCart()`: Empty the cart
- `totalPrice`: Calculate cart total
- `itemCount`: Get total items in cart
- **ChangeNotifier** for reactive UI updates

#### AuthService
- **Singleton pattern** for authentication state
- `signInWithEmail()`: Email/password sign-in
- `signUpWithEmail()`: Create new account
- `signInWithGoogle()`: Google OAuth
- `signInWithFacebook()`: Facebook OAuth
- `signOut()`: Log out user
- `updateProfile()`: Update user display name
- `currentUser`: Access authenticated user
- **ChangeNotifier** for reactive UI updates

#### ProductService
- In-memory product data storage
- Product retrieval by category
- Product search functionality
- Sample product data generation

## 🛠️ Installation & Setup

### Prerequisites
- Flutter SDK (>=2.17.0 <4.0.0)
- Dart SDK
- Chrome browser (for web testing)
- Git

### Setup Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/adefola-lab/union_shop.git
   cd union_shop
  
2. **Install dependencies:**
   ```bash
   flutter pub get

3. **Verify Flutter installation:**
   ```bash
   flutter doctor

4. **Run the application:**
   ```bash
   flutter run -d chrome

For mobile view in Chrome:

Open Chrome DevTools (F12)
Click "Toggle device toolbar" (Ctrl+Shift+M)
Select a mobile device preset (e.g., iPhone 12 Pro)

🧪 Testing
Test Coverage
The application includes comprehensive test suites covering:

//Widget Tests: UI component testing
//Unit Tests: Service logic testing
//Integration Tests: End-to-end user flows
//Running Tests
//Run all tests:
//flutter test
Run specific test file:
//flutter test test/cart_test.dart

Run with coverage:
//flutter test --coverage

Test Suites:
widget_test.dart:
Home page rendering
Carousel functionality
Product card display
Navigation flows
cart_test.dart
Cart service operations (add, remove, update)
Cart UI rendering
Quantity controls
Price calculations
Checkout flow
auth_test.dart
Email/password authentication
Social authentication (Google, Facebook)
Sign-up validation
Profile updates
Sign-out functionality
search_test.dart
Search UI rendering
Product filtering
Case-insensitive search
Results display
personalisation_test.dart
Text input validation
Character limits
Dynamic pricing (£3 vs £5)
Line selection
Add to cart with customization
collection_test.dart
Collection page rendering
Product filtering
Sort functionality
Category filtering
integration_test.dart
Complete user flows
Add to cart → checkout
Sign up → sign in → profile update
Search → view product → add to cart

🔧 Configuration
Responsive Breakpoints
// Mobile: < 600px
// Tablet: 600px - 900px
// Desktop: > 900px
// Large Desktop: > 1200px

Color Scheme
Primary: University of Portsmouth branding colors
Accent: Interactive elements
Background: White with subtle grays
Text: Dark gray for readability

📝 Usage Examples
Adding a Product to Cart
// With variants
CartService().addItem(product, size: 'M', color: 'Blue');

// Without variants
CartService().addItem(product);

Authentication
// With variants
CartService().addItem(product, size: 'M', color: 'Blue');

// Without variants
CartService().addItem(product);

Navigation
// Navigate to product page
Navigator.pushNamed(
  context,
  '/product',
  arguments: {'product': product}
);

// Navigate to collection
Navigator.pushNamed(
  context,
  '/collection',
  arguments: {
    'title': 'Sale Items',
    'category': 'sale'
  }
);

📦 Dependencies
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

No external packages are used for authentication, state management, or data persistence to demonstrate core Flutter capabilities and meet coursework requirements.

🐛 Known Issues & Limitations
Authentication: Simulated backend without persistent storage
Cart Persistence: Cart clears on app restart
Product Data: Limited sample products, not dynamically loaded
Payment: Checkout is simulated without real transactions
Image Loading: Uses placeholder URLs, may have network delays
📄 License
This project is created for educational purposes as part of the University of Portsmouth coursework for Programming Applications and Programming Languages (M30235) and User Experience Design and Implementation (M32605).

👥 Contributing
This is a coursework project. Contributions are not accepted to maintain academic integrity.

📧 Support
For issues or questions related to this implementation, contact the course instructors or use the dedicated Discord channel for the module. Or contact my email: adefolaadeoye@gmail.com