# Job Mobile App

A Flutter mobile application for job seekers to browse jobs, manage resumes, and apply for positions. Built with clean architecture, GetX state management, and modern UI design.

## Features

### ✅ Implemented
- **Authentication System**
  - User registration and login
  - Token-based authentication
  - Secure token storage
  - Profile management

- **Job Browsing**
  - List jobs with pagination
  - Search functionality
  - Filter by job type (full-time, part-time, hybrid, remote)
  - Modern job cards with company info and salary
  - Pull-to-refresh and load more functionality

- **Modern UI/UX**
  - Clean, modern design matching the web app
  - Dark/Light theme support
  - Responsive layout
  - Smooth animations and transitions
  - Gradient buttons and cards

### 🚧 In Progress
- **Resume Management**
  - Upload resume files (PDF, DOC, DOCX)
  - AI-powered resume analysis
  - Resume management (list, update, delete)

- **Job Applications**
  - Apply for jobs using resumes
  - Track application status
  - AI-powered application scoring

## Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants
│   ├── theme/             # App theme and colors
│   ├── services/          # API service
│   └── errors/            # Error handling
├── features/              # Feature modules
│   ├── auth/              # Authentication
│   │   ├── data/          # Data layer
│   │   ├── domain/        # Business logic
│   │   └── presentation/  # UI layer
│   ├── jobs/              # Job browsing
│   ├── resumes/           # Resume management
│   ├── applications/      # Job applications
│   └── profile/           # User profile
└── shared/                # Shared components
    ├── models/            # Shared models
    └── widgets/           # Reusable widgets
```

## Tech Stack

- **Framework**: Flutter 3.9.0+
- **State Management**: GetX
- **HTTP Client**: Dio
- **Local Storage**: GetStorage
- **File Picker**: file_picker
- **Architecture**: Clean Architecture
- **UI**: Material Design 3

## API Integration

The app integrates with the Laravel backend API:

- **Base URL**: `https://job-app-main-2uhwu4.laravel.cloud/api/v1/`
- **Authentication**: Bearer Token
- **Rate Limiting**: 60 requests/minute (API), 5 requests/minute (Auth)

### Endpoints Used
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout
- `GET /profile` - Get user profile
- `PUT /profile` - Update user profile
- `GET /jobs` - List jobs with pagination and filters
- `GET /jobs/{id}` - Get job details

## Getting Started

### Prerequisites
- Flutter SDK 3.9.0 or higher
- Dart 3.0.0 or higher
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd job-mobile-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Configuration

The app is pre-configured to work with the existing Laravel API. No additional configuration is required.

## Project Structure

### Core Modules

#### Authentication (`features/auth/`)
- **Domain**: Entities, repositories, use cases
- **Data**: Remote data sources, repository implementations
- **Presentation**: Controllers, pages, widgets

#### Jobs (`features/jobs/`)
- **Domain**: Job entities, repositories, use cases
- **Data**: API data sources, repository implementations
- **Presentation**: Controllers, pages, widgets

### Key Components

#### API Service (`core/services/api_service.dart`)
- Centralized HTTP client using Dio
- Automatic token management
- Error handling and response parsing
- Request/response interceptors

#### Theme (`core/theme/app_theme.dart`)
- Material Design 3 implementation
- Light and dark theme support
- Custom color palette matching the web app
- Consistent typography and spacing

#### State Management
- GetX controllers for each feature
- Reactive programming with observables
- Dependency injection
- Route management

## Development

### Adding New Features

1. Create feature folder structure:
   ```
   features/new_feature/
   ├── data/
   │   ├── datasources/
   │   └── repositories/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   └── presentation/
       ├── controllers/
       ├── pages/
       └── widgets/
   ```

2. Implement clean architecture layers
3. Add to dependency injection in `main.dart`
4. Create routes and navigation

### Code Style

- Follow Flutter/Dart conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent indentation (2 spaces)

## Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run tests with coverage
flutter test --coverage
```

## Building

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is part of the job application system and follows the same license terms.

## Support

For support and questions, please contact the development team or create an issue in the repository.