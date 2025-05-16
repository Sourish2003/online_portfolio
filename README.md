# Flutter Portfolio

A modern, responsive portfolio website built with Flutter Web.

## ✨ Features

- **Responsive Design** - Looks great on desktop, tablet, and mobile devices
- **Dark/Light Mode** - Toggle between themes with a single click
- **Modern UI** - Beautiful glassmorphic card designs with subtle animations
- **Animated Sections** - Smooth reveal animations and parallax effects
- **Interactive Elements** - Hover effects and interactive UI components
- **Section Navigation** - Easy navigation with scrollable sections
- **Contact Form** - Built-in contact form with validation
- **Customizable** - Easily update with your own information

## 🛠️ Technologies Used

- **Flutter Web** - For cross-platform deployment
- **Responsive Framework** - For adaptive layouts
- **Custom Animations** - Parallax effects and staggered animations
- **Material Design 3** - Modern UI components with custom theming
- **Google Fonts** - Typography with Montserrat and Roboto

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository

    ```bash
    git clone https://github.com/yourusername/flutter_portfolio.git
    cd flutter_portfolio
    ```

2. Install dependencies

    ```bash
    flutter pub get
    ```

3. Run the project

    ```bash
    flutter run -d chrome
    ```

## 🎨 Customization

### Updating Personal Information

Edit the following files to customize your portfolio:

- **Contact Information**: `contact_section.dart`
- **Projects**: `projects_section.dart`
- **Skills**: `about_section.dart`
- **Experience & Education**: `about_section.dart`
- **Social Links**: `home_screen.dart`

### Changing Theme Colors

Modify the theme colors in `themes.dart`:

```dart
static final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4), // Update this color
    // Other color configurations...
  ),
  // Other theme settings...
);
```

### Adding Custom Sections

To add a new section:

1. Create a new section file in the `sections` folder
2. Add a reference to it in `home_screen.dart`
3. Add a new section key and update the navigation

## 📱 Deployment

### Building for Web

```bash
flutter build web --release
```

The output will be in the `build/web` directory, which you can deploy to any web hosting service.

### Building for Other Platforms

This portfolio template can also be built for other platforms:

```bash
# For Android
flutter build apk --release

# For iOS
flutter build ios --release

# For macOS
flutter build macos --release

# For Windows
flutter build windows --release

# For Linux
flutter build linux --release
```

## 📝 Project Structure

```
lib/
├── animations/        # Custom animations
├── constants/         # App constants
├── screens/           # Main screens
│   └── sections/      # Portfolio sections
├── themes/            # Theme configuration
├── widgets/           # Reusable widgets
└── main.dart          # App entry point
```

## 🔧 Performance Optimizations

This portfolio includes several optimizations:

- Efficient resource loading
- Optimized animations
- Responsive design with minimal rebuilds
- Proper widget tree structure
- Memory management for images and animations

## 💡 Tips for Customization

- Replace placeholder images with your own portfolio projects
- Update the color scheme to match your personal brand
- Modify section content to showcase your skills and experience
- Add or remove sections based on your needs
- Customize animations to match your style

---

Made with Flutter ❤️
