# Job Mobile App

A comprehensive Flutter mobile application for job seekers to browse jobs, manage resumes, and apply for positions. Built with clean architecture, GetX state management, and modern Material Design 3 UI.

## Features

### ✅ Fully Implemented

#### **Authentication System**
- User registration and login
- Token-based authentication with secure storage
- Profile management and updates
- Automatic token refresh
- Secure logout functionality

#### **Job Management**
- **Job Browsing**: List jobs with pagination and infinite scroll
- **Advanced Search**: Search by keywords, location, and job type
- **Smart Filtering**: Filter by job type (full-time, part-time, hybrid, remote)
- **Job Details**: Comprehensive job information with company details
- **One-Click Application**: Apply for jobs with resume selection
- **Modern UI**: Beautiful job cards with company info, salary, and requirements

#### **Resume Management**
- **File Upload**: Upload resume files (PDF, DOC, DOCX)
- **AI Analysis**: AI-powered resume analysis with skills extraction
- **Resume Details**: Complete resume information display
- **File Management**: View, download, edit, and delete resumes
- **Application Tracking**: Track which jobs each resume was used for

#### **Application Tracking**
- **Application History**: Complete list of all job applications
- **AI Scoring**: AI-powered application scoring and feedback
- **Status Tracking**: Real-time application status updates
- **Detailed Views**: Comprehensive application details with timeline
- **Progress Visualization**: AI score visualization with progress bars

#### **Advanced UI/UX**
- **Material Design 3**: Modern, consistent design system
- **Dark/Light Theme**: Complete theme support with system preference
- **Responsive Design**: Optimized for all screen sizes
- **Smooth Animations**: Flutter Staggered Animations for enhanced UX
- **Loading States**: Shimmer effects and loading indicators
- **Error Handling**: Comprehensive error states with retry options
- **Offline Support**: Cached data available offline

#### **Performance & Caching**
- **Hive Caching**: High-performance local data caching
- **Smart Cache Management**: Automatic cache expiration and invalidation
- **Offline Capability**: Cached data available without internet
- **Memory Optimization**: Efficient memory management and disposal
- **Network Monitoring**: Real-time network status detection

### 🚀 Recent Enhancements

#### **New Pages & Features**
- **Job Details Page**: Complete job information with company details
- **Resume Details Page**: AI analysis and file management
- **Application Details Page**: Comprehensive application tracking
- **Enhanced Search Bar**: Advanced filtering with collapsible options
- **Apply Job Bottom Sheet**: Streamlined job application process

#### **UI Components**
- **Error Widgets**: Standardized error, loading, and empty states
- **Network Status Widget**: Offline/online status monitoring
- **Theme Toggle Widgets**: Multiple theme switching options
- **Cache Management Widget**: Cache statistics and management
- **Shimmer Effects**: Beautiful loading placeholders

#### **Technical Improvements**
- **Repository-Level Caching**: Clean architecture with Hive integration
- **Enhanced Controllers**: Improved state management and error handling
- **Better Error Handling**: Comprehensive error boundaries and recovery
- **Performance Optimizations**: Lazy loading and memory management

## Architecture

The app follows **Clean Architecture** principles with clear separation of concerns and **MVVM pattern**:

```
lib/
├── core/                           # Core functionality
│   ├── bindings/                   # Dependency injection bindings
│   ├── cache/                      # Hive cache management
│   ├── constants/                  # App constants and API endpoints
│   ├── controllers/                # Global controllers
│   ├── errors/                     # Error handling and exceptions
│   ├── navigation/                 # Route management and navigation
│   ├── services/                   # Core services (API, Theme, Snackbar)
│   ├── theme/                      # App theme and styling
│   └── utils/                      # Utility functions and helpers
├── features/                       # Feature modules (Clean Architecture)
│   ├── auth/                       # Authentication feature
│   │   ├── data/                   # Data layer
│   │   │   ├── datasources/        # Remote data sources
│   │   │   └── repositories/       # Repository implementations
│   │   ├── domain/                 # Business logic layer
│   │   │   ├── entities/           # Domain entities
│   │   │   ├── repositories/       # Repository interfaces
│   │   │   └── usecases/           # Use cases
│   │   └── presentation/           # Presentation layer
│   │       ├── controllers/        # GetX controllers
│   │       ├── pages/              # UI pages/screens
│   │       └── widgets/            # Feature-specific widgets
│   ├── jobs/                       # Job browsing and management
│   ├── resumes/                    # Resume management
│   ├── applications/               # Job applications
│   └── profile/                    # User profile management
└── shared/                         # Shared components
    ├── models/                     # Shared data models
    ├── pages/                      # Shared pages
    ├── utils/                      # Shared utilities
    └── widgets/                    # Reusable UI widgets
```

### **Architecture Layers**

#### **Presentation Layer** (UI)
- **Controllers**: GetX controllers for state management
- **Pages**: Flutter screens and UI components
- **Widgets**: Reusable UI components

#### **Domain Layer** (Business Logic)
- **Entities**: Core business objects
- **Use Cases**: Application-specific business rules
- **Repository Interfaces**: Abstract data access contracts

#### **Data Layer** (Data Access)
- **Data Sources**: Remote API and local cache data sources
- **Repository Implementations**: Concrete implementations of domain repositories
- **Models**: Data transfer objects and API response models

#### **Core Layer** (Infrastructure)
- **Services**: Cross-cutting concerns (API, caching, theming)
- **Cache Management**: Hive-based local data caching
- **Navigation**: Route management and deep linking
- **Error Handling**: Centralized error management

## Tech Stack

### **Core Framework**
- **Flutter**: 3.9.0+ with Dart 3.0.0+
- **Architecture**: Clean Architecture with MVVM pattern
- **State Management**: GetX 4.6.6+ (reactive programming)

### **HTTP & Networking**
- **HTTP Client**: Dio 5.4.0+ (advanced HTTP client)
- **API Integration**: RESTful API with Laravel backend
- **Error Handling**: Comprehensive error management

### **Local Storage & Caching**
- **Primary Cache**: Hive 2.2.3+ (high-performance NoSQL database)
- **Secondary Storage**: GetStorage 2.1.1+ (key-value storage)
- **Preferences**: SharedPreferences 2.2.2+ (user preferences)

### **File Management**
- **File Picker**: file_picker 6.1.1+ (document selection)
- **File Handling**: Native file system integration
- **Supported Formats**: PDF, DOC, DOCX

### **UI & Design**
- **Design System**: Material Design 3
- **Icons**: Cupertino Icons 1.0.8+
- **Images**: Cached Network Image 3.3.0+ (optimized image loading)
- **Animations**: Flutter Staggered Animations 1.1.1+
- **Loading**: Shimmer 3.0.0+ (loading placeholders)

### **Utilities & Services**
- **Internationalization**: intl 0.19.0+ (date/time formatting)
- **URL Launcher**: url_launcher 6.2.2+ (external links)
- **Permissions**: permission_handler 11.2.0+ (device permissions)
- **SVG Support**: flutter_svg 2.0.9+ (vector graphics)

### **Development Tools**
- **Linting**: flutter_lints 5.0.0+ (code quality)
- **Debugging**: pretty_dio_logger 1.4.0+ (network logging)
- **Testing**: Flutter Test Framework

## API Integration

The app integrates with the Laravel backend API with comprehensive error handling and caching:

- **Base URL**: `https://job-app-main-2uhwu4.laravel.cloud/api/v1/`
- **Authentication**: Bearer Token with automatic refresh
- **Rate Limiting**: 60 requests/minute (API), 5 requests/minute (Auth)
- **Caching**: Hive-based local caching for improved performance
- **Error Handling**: Comprehensive error management with retry logic

### **Authentication Endpoints**
- `POST /auth/register` - User registration
- `POST /auth/login` - User login with token generation
- `POST /auth/logout` - User logout and token invalidation
- `POST /auth/refresh` - Token refresh (automatic)

### **Profile Management**
- `GET /profile` - Get user profile information
- `PUT /profile` - Update user profile
- `GET /profile/avatar` - Get user avatar
- `POST /profile/avatar` - Upload user avatar

### **Job Management**
- `GET /jobs` - List jobs with pagination, search, and filters
- `GET /jobs/{id}` - Get detailed job information
- `POST /jobs/{id}/apply` - Apply for a job with resume
- `GET /jobs/search` - Advanced job search with filters

### **Resume Management**
- `GET /resumes` - List user resumes
- `POST /resumes` - Upload new resume file
- `GET /resumes/{id}` - Get resume details and AI analysis
- `PUT /resumes/{id}` - Update resume information
- `DELETE /resumes/{id}` - Delete resume

### **Application Tracking**
- `GET /applications` - List user job applications
- `GET /applications/{id}` - Get application details and AI score
- `GET /applications/status/{status}` - Filter applications by status

### **Response Format**
All API responses follow a consistent format:
```json
{
  "success": true,
  "message": "Operation successful",
  "data": { ... },
  "meta": {
    "pagination": { ... },
    "filters": { ... }
  }
}
```

## Caching & Offline Support

The app implements a comprehensive caching system using **Hive** for high-performance local data storage:

### **Cache Architecture**
- **Repository-Level Caching**: Clean architecture with caching at the data layer
- **Automatic Expiration**: Smart cache expiration based on data type
- **Offline Capability**: Cached data available without internet connection
- **Memory Optimization**: Efficient memory management and disposal

### **Cache Duration**
- **Jobs**: 30 minutes (frequently updated data)
- **Job Details**: 30 minutes (individual job information)
- **User Profile**: 1 hour (stable user data)
- **Resumes**: 45 minutes (user-generated content)
- **Applications**: 20 minutes (real-time tracking data)

### **Cache Management**
- **Automatic Invalidation**: Cache cleared when data is modified
- **Manual Refresh**: Force refresh option bypasses cache
- **Cache Statistics**: Monitor cache usage and performance
- **Error Recovery**: Fallback to API when cache fails

### **Offline Features**
- **Cached Job Listings**: Browse jobs without internet
- **Resume Management**: View and manage resumes offline
- **Application History**: Access application details offline
- **Network Status**: Real-time online/offline detection

## Dark Mode & Theming

The app provides comprehensive theme support with Material Design 3:

### **Theme Options**
- **Light Mode**: Traditional light theme with white backgrounds
- **Dark Mode**: Dark theme with dark backgrounds and light text
- **System Mode**: Automatically follows device system theme

### **Theme Features**
- **Persistent Storage**: Theme preference saved across app restarts
- **Smooth Transitions**: Animated theme switching
- **Consistent Styling**: Material Design 3 color system
- **Accessibility**: Proper contrast ratios for readability

### **Customization**
- **Color Palette**: Custom blue gradient theme (`#3B82F6` to `#9333EA`)
- **Component Theming**: Consistent styling across all UI components
- **Dynamic Colors**: Theme-aware color usage throughout the app

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

## Key Features Deep Dive

### **Job Management System**
- **Smart Search**: Advanced search with keyword, location, and job type filters
- **Job Details**: Comprehensive job information including company details, requirements, and statistics
- **One-Click Application**: Streamlined application process with resume selection
- **Real-time Updates**: Live job listings with pull-to-refresh functionality

### **Resume Management System**
- **File Upload**: Support for PDF, DOC, and DOCX files with validation
- **AI Analysis**: Automatic resume analysis with skills extraction and scoring
- **Resume Details**: Complete resume information with AI feedback and statistics
- **File Management**: View, download, edit, and delete resume files
- **Application Tracking**: Track which jobs each resume was used for

### **Application Tracking System**
- **Application History**: Complete list of all job applications with status tracking
- **AI Scoring**: AI-powered application scoring with detailed feedback
- **Status Management**: Real-time application status updates (Pending, Accepted, Rejected)
- **Detailed Views**: Comprehensive application details with timeline and progress visualization
- **Performance Analytics**: Track application success rates and AI scores

### **Advanced UI Components**
- **Error Handling**: Standardized error, loading, and empty state widgets
- **Network Monitoring**: Real-time online/offline status detection with retry functionality
- **Theme Management**: Complete dark/light theme support with system preference
- **Loading States**: Beautiful shimmer effects and loading indicators
- **Cache Management**: Cache statistics and management widgets

## Project Structure

### **Core Modules**

#### **Authentication** (`features/auth/`)
- **Domain**: User entities, authentication repositories, login/register use cases
- **Data**: API data sources, token management, secure storage
- **Presentation**: Login/register pages, profile management, authentication controllers

#### **Jobs** (`features/jobs/`)
- **Domain**: Job entities, search repositories, job management use cases
- **Data**: Job API integration, search functionality, job details caching
- **Presentation**: Job listing, job details, search filters, application flow

#### **Resumes** (`features/resumes/`)
- **Domain**: Resume entities, file management, AI analysis use cases
- **Data**: File upload, resume processing, AI integration
- **Presentation**: Resume management, file upload, AI analysis display

#### **Applications** (`features/applications/`)
- **Domain**: Application entities, tracking repositories, application use cases
- **Data**: Application API, status tracking, AI scoring integration
- **Presentation**: Application history, detailed views, status tracking

### **Key Components**

#### **API Service** (`core/services/api_service.dart`)
- **Centralized HTTP Client**: Dio-based HTTP client with interceptors
- **Automatic Token Management**: Bearer token handling with refresh
- **Error Handling**: Comprehensive error management and retry logic
- **Request/Response Logging**: Debug logging for development
- **Rate Limiting**: Built-in rate limiting and throttling

#### **Cache Management** (`core/cache/hive_cache_manager.dart`)
- **Hive Integration**: High-performance NoSQL database for caching
- **Smart Expiration**: Automatic cache expiration based on data type
- **Cache Statistics**: Monitor cache usage and performance
- **Offline Support**: Cached data available without internet
- **Memory Optimization**: Efficient memory management and cleanup

#### **Theme System** (`core/theme/app_theme.dart`)
- **Material Design 3**: Complete Material Design 3 implementation
- **Dark/Light Themes**: Full theme support with system preference
- **Custom Color Palette**: Blue gradient theme (`#3B82F6` to `#9333EA`)
- **Consistent Styling**: Typography, spacing, and component theming
- **Accessibility**: Proper contrast ratios and accessibility support

#### **State Management** (GetX)
- **Reactive Programming**: Observable variables and reactive updates
- **Dependency Injection**: Automatic dependency injection and management
- **Route Management**: Navigation and routing with GetX
- **Controller Lifecycle**: Proper controller initialization and disposal
- **Error Handling**: Centralized error state management

## Performance & Optimization

### **Caching Strategy**
- **Repository-Level Caching**: Clean architecture with Hive integration
- **Smart Cache Invalidation**: Automatic cache clearing on data updates
- **Memory Management**: Efficient memory usage and garbage collection
- **Offline Capability**: Full offline functionality with cached data

### **UI Performance**
- **Lazy Loading**: Images and data loaded on demand
- **Shimmer Effects**: Beautiful loading placeholders
- **Smooth Animations**: Flutter Staggered Animations for enhanced UX
- **Responsive Design**: Optimized for all screen sizes and orientations

### **Network Optimization**
- **Request Caching**: API responses cached locally
- **Pagination**: Efficient data loading with pagination
- **Error Recovery**: Automatic retry logic for failed requests
- **Network Monitoring**: Real-time connection status detection

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

## App Screenshots & Demo

### **Main Features**
- **Job Browsing**: Modern job cards with company information and salary details
- **Job Details**: Comprehensive job information with company details and requirements
- **Resume Management**: AI-powered resume analysis and file management
- **Application Tracking**: Real-time application status with AI scoring
- **Advanced Search**: Smart filtering by job type, location, and keywords

### **UI/UX Highlights**
- **Material Design 3**: Modern, consistent design system
- **Dark/Light Theme**: Complete theme support with smooth transitions
- **Responsive Design**: Optimized for all screen sizes
- **Smooth Animations**: Flutter Staggered Animations for enhanced UX
- **Loading States**: Beautiful shimmer effects and loading indicators

## Future Roadmap

### **Planned Features**
- **Push Notifications**: Real-time application status updates
- **Advanced Filters**: Salary range, experience level, and more filters
- **Favorites System**: Save and manage favorite jobs
- **Job Recommendations**: AI-powered job suggestions
- **Enhanced Profile**: More detailed user profiles and preferences
- **Settings Page**: App preferences and notification settings
- **Search History**: Track and manage search history
- **Offline Sync**: Background data synchronization

### **Technical Improvements**
- **Performance Optimization**: Further memory and CPU optimizations
- **Testing Coverage**: Comprehensive unit and integration tests
- **Accessibility**: Enhanced accessibility features
- **Internationalization**: Multi-language support
- **Analytics**: User behavior and performance analytics

## Support

For support and questions, please contact the development team or create an issue in the repository.

---

## 📱 **App Summary**

The **Job Mobile App** is a comprehensive Flutter application that provides job seekers with a complete platform for job searching, resume management, and application tracking. Built with modern architecture principles and Material Design 3, the app offers:

- ✅ **Complete Job Management** - Browse, search, filter, and apply for jobs
- ✅ **AI-Powered Resume Analysis** - Upload and analyze resumes with AI feedback
- ✅ **Real-time Application Tracking** - Track applications with AI scoring
- ✅ **Modern UI/UX** - Material Design 3 with dark/light theme support
- ✅ **Offline Capability** - Hive-based caching for offline functionality
- ✅ **Performance Optimized** - Efficient memory management and smooth animations

**Total Features**: 25+ major features  
**Architecture**: Clean Architecture with MVVM pattern  
**State Management**: GetX reactive programming  
**Caching**: Hive NoSQL database  
**UI Framework**: Material Design 3  
**Platform Support**: iOS and Android  

The app is production-ready and provides a seamless experience for job seekers! 🚀