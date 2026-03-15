# EmPoverty - Quick Start Guide

## 🚀 Quick Setup (5 minutes)

### Step 1: Navigate to Project
```bash
cd e:\Flutter Project\empoverty
```

### Step 2: Get Dependencies
```bash
flutter pub get
```

### Step 3: Run the App
```bash
flutter run
```

### Recent Updates (Latest Build)
- ✨ Phone dialer integration - Call service providers directly
- 🔧 Fixed all layout overflow issues across all pages
- 📱 Improved responsive design for all screen sizes
- 🎯 Service providers now appear in list immediately after registration

## 📱 App Flow

### Welcome Screen
- **Join as Service Provider**: Register as a skilled worker
- **Continue as Customer**: Browse available services

## 👤 User Registration Types

### 1. Service Provider Registration
1. Enter personal information (name, email, phone)
2. Select your service category
3. Write professional bio (optional)
4. Pick your location on map
5. Complete registration
6. Service provider appears in the service providers list on home page

### 2. Customer Flow
1. View all registered service providers
2. Filter by service type
3. View provider details:
   - Profile and ratings
   - Skills and certifications
   - Location
   - Call button (opens native phone dialer)

## 🛠️ Main Features to Explore

### 1. Service Provider Discovery
- Browse all registered service providers on home page
- Filter by service type using filter chips
- View ratings and review counts
- See detailed provider information

### 2. Detailed Provider View
- Full provider profile with name and category
- Verification badge (if verified)
- Customer ratings and review count
- Professional bio
- Skills and expertise tags
- Certificate gallery (if available)
- Location address with icon
- Full-width "Call to Inquire" button

### 3. Location Services
- Auto-detect user current location
- Location-based filtering (upcoming)
- Map view of providers (upcoming)

### 4. Phone Integration
- Click "Call to Inquire" to directly call the service provider
- Uses native phone dialer on Android and iOS
- Cleans phone number format automatically

## 📝 Demo Data

The app comes pre-loaded with sample data:

**Sample Workers:**
- **Ramesh Kumar** (Plumber)
  - Phone: 9876543210
  - Experience: 10+ years
  - Location: 789 Worker Lane
  - Rating: 4.6/5 (35 reviews)
  - Verified: ✅

- **Priya Singh** (Electrician)
  - Phone: 9123456780
  - Experience: Licensed professional
  - Location: 321 Service Road
  - Rating: 4.7/5 (42 reviews)
  - Verified: ✅

You can test the app by:
1. Logging in as a customer
2. Viewing the service providers list
3. Clicking on any provider to see details
4. Clicking "Call to Inquire" to test the phone dialer

## 🔐 Current Features (v1.0)

- ✅ User registration (Service Provider / Customer)
- ✅ Service provider registration and listing
- ✅ Location management (auto-detect location)
- ✅ Service filtering by category
- ✅ Provider listing and details pages
- ✅ Rating display
- ✅ Phone dialer integration (native call feature)
- ✅ Responsive design (all screen sizes)
- ✅ Scrollable content (no overflow issues)

## 🚧 Features Under Development

- 🔄 Backend API integration
- 🔄 Firebase authentication
- 🔄 Real-time messaging
- 🔄 Payment integration
- 🔄 Advanced search filters
- 🔄 User reviews and ratings

## 🎨 Customization

### Change Theme Colors
Edit `lib/theme/app_theme.dart`:
```dart
static const Color primary = Color(0xFF2196F3); // Change primary color
static const Color secondary = Color(0xFFFF9800); // Change secondary color
```

### Add Your Own Services
Edit `lib/providers/service_provider.dart`:
```dart
ServiceCategory(
  id: 'new_id',
  name: 'Your Service',
  icon: '🆕',
  description: 'Service description',
),
```

### Modify Sample Data
Edit the respective providers in `lib/providers/`:
- `shopkeeper_provider.dart` - Add sample shopkeepers
- `worker_provider.dart` - Add sample workers

## 📱 Testing on Different Devices

### Android
```bash
flutter run -d yourDeviceId
```
- Phone dialer will work on all Android 6.0+ devices
- Make sure to allow phone permission

### iOS
```bash
flutter run -d yourDeviceId
```
- Phone dialer will work on all iOS devices
- Tested on iOS 11+

### Web (if enabled)
```bash
flutter run -d chrome
```
- Phone dialer not supported on web

## 🐛 Common Issues & Solutions

### Issue: Build fails with "plugin not found"
**Solution:**
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Location permission denied
**Solution:**
- Android: Enable location in app settings
- iOS: Check Info.plist for location permissions

### Issue: Hot reload not working
**Solution:**
```bash
flutter run
# Or
flutter clean && flutter run
```

### Issue: Phone dialer not opening
**Solution:**
- Make sure the service provider has a valid phone number
- Android: Ensure AndroidManifest.xml has tel scheme in queries (already configured)
- iOS: Ensure Info.plist has LSApplicationQueriesSchemes (already configured)
- Clear build cache: `flutter clean && flutter run`

### Note on Recent Fixes (v1.0+)
- ✅ Fixed RenderFlex overflow on all pages (welcome, worker cards, buttons)
- ✅ All text now properly handles long names with ellipsis
- ✅ Buttons are now responsive and full-width where needed
- ✅ All content is scrollable to prevent overflow

## 📚 Project Structure Quick Reference

```
empoverty/
├── lib/
│   ├── main.dart              # Start here
│   ├── models/                # Data structures
│   ├── pages/                 # Screens
│   ├── providers/             # State management
│   ├── theme/                 # Colors & styles
│   ├── widgets/               # Reusable components
│   ├── utils/                 # Helper functions
│   └── constants/             # App constants
└── pubspec.yaml               # Dependencies
```

## 🔗 Important Files to Know

1. **lib/main.dart** - App entry point, routes setup
2. **lib/pages/welcome_page.dart** - First screen
3. **lib/pages/home_page.dart** - Customer dashboard
4. **lib/theme/app_theme.dart** - Design system
5. **lib/providers/auth_provider.dart** - User management

## 🎯 Next Steps

1. **Explore the Code**
   - Start with `lib/main.dart`
   - Follow the navigation routes
   - Check out the providers

2. **Run the App**
   - Navigate to registration
   - Test different user flows
   - Explore the home screen

3. **Customize**
   - Change colors and themes
   - Add your own services
   - Modify data models

4. **Integrate Backend**
   - Replace mock API calls with real endpoints
   - Set up authentication
   - Connect to database

## 📞 Support Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Dart Language](https://dart.dev)

## 📈 Performance Tips

1. Use `const` constructors where possible
2. Implement lazy loading for large lists
3. Use `ListView.builder()` instead of `ListView()`
4. Implement image caching

## ✅ Checklist Before Going Live

- [ ] Test phone dialer on real Android device
- [ ] Test phone dialer on real iOS device
- [ ] Replace mock data with real API integration
- [ ] Set up Firebase authentication
- [ ] Add email verification
- [ ] Implement proper error handling
- [ ] Add loading states to all API calls
- [ ] Test on multiple screen sizes
- [ ] Optimize image loading and caching
- [ ] Add analytics tracking
- [ ] Implement security (encrypted phone numbers)
- [ ] Test all user registration flows
- [ ] Set up backend database
- [ ] Add payment integration
- [ ] Implement real-time messaging

---

**Happy Coding! 🚀**

For detailed documentation, see `README_EMPOVERTY.md`
