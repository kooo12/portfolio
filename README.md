# 🚀 Professional Portfolio

A modern, responsive Flutter web portfolio showcasing skills, projects, and experience with beautiful animations and professional design.

## 🌐 Live Demo

**Visit the live portfolio:** [https://myprotfolio-ba6ef.web.app](https://myprotfolio-ba6ef.web.app)

## ✨ Features

### 🎨 **Modern Design**
- **Responsive Layout** - Perfect on desktop, tablet, and mobile
- **Dark/Light Theme** - Toggle between themes with smooth transitions
- **Animated Background** - Dynamic geometric patterns with floating elements
- **Gradient Design** - Beautiful color schemes and visual effects

### 📱 **Sections**
- **Hero Section** - Professional introduction with call-to-action
- **About** - Personal story and background
- **Skills** - Interactive skill cards with proficiency indicators
- **Experience** - Professional timeline with detailed descriptions
- **Projects** - Portfolio showcase with filtering and categories
- **Contact** - Multiple contact methods and social links

### 🔧 **Technical Features**
- **Flutter Web** - Cross-platform compatibility
- **GetX State Management** - Reactive programming and dependency injection
- **Firebase Hosting** - Fast, reliable deployment
- **PWA Support** - Installable web app experience
- **SEO Optimized** - Meta tags and structured data
- **Performance Optimized** - Lazy loading and efficient rendering

### 🎯 **Interactive Elements**
- **Smooth Scrolling** - Navigation with automatic section highlighting
- **Hover Effects** - Interactive cards and buttons
- **Loading Animations** - Beautiful loading states
- **Responsive Navigation** - Mobile-friendly menu system

## 🛠️ Tech Stack

- **Framework:** Flutter 3.x
- **Language:** Dart
- **State Management:** GetX
- **Animations:** Flutter Animate
- **Icons:** Font Awesome Flutter
- **Hosting:** Firebase Hosting
- **Deployment:** Firebase CLI

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: 5.0.0-release-candidate-9.2
  flutter_animate: ^4.5.0
  font_awesome_flutter: ^10.6.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK
- Firebase CLI (for deployment)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/kooo12/portfolio.git
   cd portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run locally**
   ```bash
   flutter run -d web-server --web-port 8080
   ```

4. **Build for production**
   ```bash
   flutter build web --release
   ```

## 🚀 Deployment

### Firebase Hosting

1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**
   ```bash
   firebase login
   ```

3. **Initialize Firebase** (if not already done)
   ```bash
   firebase init hosting
   ```

4. **Deploy**
   ```bash
   flutter build web --release
   firebase deploy
   ```

## 📁 Project Structure

```
lib/
├── bindings/          # GetX bindings
├── controllers/       # State management
│   ├── navigation_controller.dart
│   ├── portfolio_controller.dart
│   └── theme_controller.dart
├── models/           # Data models
│   └── skill.dart
├── utils/            # Utilities
│   ├── app_colors.dart
│   └── app_dimensions.dart
├── views/            # Main views
│   └── portfolio_view.dart
├── widgets/          # Reusable widgets
│   ├── animated_background.dart
│   ├── header.dart
│   ├── hero_section.dart
│   ├── skills_section.dart
│   ├── skill_card.dart
│   ├── about_section.dart
│   ├── experience_section.dart
│   ├── projects_section.dart
│   ├── contact_section.dart
│   └── footer.dart
└── main.dart
```

## 🎨 Customization

### Colors
Edit `lib/utils/app_colors.dart` to customize the color scheme:

```dart
class AppColors {
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color secondaryLight = Color(0xFF8B5CF6);
  static const Color accentLight = Color(0xFF06B6D4);
  // ... more colors
}
```

### Dimensions
Adjust spacing and breakpoints in `lib/utils/app_dimensions.dart`:

```dart
class AppDimensions {
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;
  // ... more dimensions
}
```

### Content
- **Personal Info:** Update `lib/controllers/portfolio_controller.dart`
- **Skills:** Modify the skills list in the controller
- **Projects:** Add your projects in the controller
- **Experience:** Update experience data in the controller

## 📱 Responsive Design

The portfolio is fully responsive with breakpoints:
- **Mobile:** < 768px
- **Tablet:** 768px - 1024px
- **Desktop:** 1024px - 1440px
- **Large Desktop:** > 1440px

## 🌟 Features Showcase

### Interactive Skill Cards
- Animated proficiency indicators
- Hover effects with detailed information
- Responsive grid layout
- Category-based organization

### Dynamic Navigation
- Automatic section highlighting
- Smooth scrolling animations
- Mobile-friendly hamburger menu
- Theme toggle functionality

### Modern Animations
- Page load animations
- Scroll-triggered effects
- Hover interactions
- Loading states

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Aung Ko Oo**
- GitHub: [@kooo12](https://github.com/kooo12)
- LinkedIn: [Aung Ko Oo](https://www.linkedin.com/in/aung-ko-oo-042342242/)
- Email: agkooo.ako36@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX for state management
- Font Awesome for beautiful icons
- Firebase for hosting and services

## 📈 Performance

- **Lighthouse Score:** 95+ across all metrics
- **First Contentful Paint:** < 1.5s
- **Largest Contentful Paint:** < 2.5s
- **Cumulative Layout Shift:** < 0.1

---

⭐ **Star this repository if you found it helpful!**
