# E-Learning Platform

A comprehensive E-Learning platform built with Flutter for the frontend and .NET 9 for the backend.

## 📁 Project Structure

```
E-Learning-Platform/
├── e_learning/           # Flutter frontend application
│   ├── lib/             # Dart source code
│   ├── assets/          # Images, videos, animations
│   ├── android/         # Android-specific files
│   ├── ios/             # iOS-specific files
│   └── pubspec.yaml     # Flutter dependencies
├── backend/             # .NET 9 Web API backend
│   ├── Controllers/     # API endpoints
│   ├── Models/          # Database entities
│   ├── Data/            # Database context
│   ├── DTOs/            # Data transfer objects
│   ├── Services/        # Business logic
│   └── Program.cs       # Application entry point
└── README.md           # This file
```

## 🚀 Technology Stack

### Frontend (Flutter)
- **Flutter 3.32.8** - Cross-platform UI framework
- **Dart** - Programming language
- **Provider** - State management
- **HTTP/Dio** - API communication
- **Shared Preferences** - Local storage
- **File Picker** - File upload functionality
- **Video Player** - Video playback
- **PDF Viewer** - Document viewing

### Backend (.NET 9)
- **.NET 9** - Latest LTS version
- **Entity Framework Core** - ORM with SQL Server
- **ASP.NET Core Identity** - User management
- **JWT Authentication** - Secure API access
- **AutoMapper** - Object mapping
- **Swagger/OpenAPI** - API documentation

## 🛠️ Setup Instructions

### Frontend Setup

1. **Navigate to the Flutter project:**
   ```bash
   cd e_learning
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### Backend Setup

1. **Navigate to the backend:**
   ```bash
   cd backend
   ```

2. **Restore dependencies:**
   ```bash
   dotnet restore
   ```

3. **Build the project:**
   ```bash
   dotnet build
   ```

4. **Run the API:**
   ```bash
   dotnet run
   ```

## 🌟 Features

### Student Features
- User registration and authentication
- Browse and search courses
- Enroll in courses
- Watch video lessons
- View course materials (PDFs, documents)
- Submit assignments
- Track learning progress
- View certificates

### Admin/Instructor Features
- Create and manage courses
- Upload course materials
- Create assignments
- Grade student submissions
- View analytics and reports
- Manage user accounts

### Technical Features
- Cross-platform mobile app (iOS/Android)
- Responsive web interface
- Real-time progress tracking
- File upload and management
- Video streaming
- PDF document viewing
- Push notifications (ready for implementation)
- Offline content caching (ready for implementation)

## 📱 App Screenshots

The app includes:
- Onboarding screens
- Login/Registration
- Home dashboard
- Course browsing
- Video player
- PDF viewer
- Assignment submission
- Progress tracking
- User profile

## 🔧 Configuration

### Frontend Configuration
Update API endpoints in `lib/services/baseurl.dart` to point to your backend server.

### Backend Configuration
Update `backend/appsettings.json` for:
- Database connection string
- JWT settings
- CORS configuration

## 🚀 Deployment

### Frontend Deployment
- **Android:** Generate APK or upload to Google Play Store
- **iOS:** Archive and upload to App Store Connect
- **Web:** Build and deploy to any web hosting service

### Backend Deployment
- **Azure App Service**
- **AWS Elastic Beanstalk**
- **Docker containers**
- **Any .NET hosting platform**

## 📚 API Documentation

Once the backend is running, visit:
- **Swagger UI:** `https://localhost:7000/swagger`
- **API Base:** `https://localhost:7000/api`

## 🔐 Authentication

The platform uses JWT tokens for secure authentication between the Flutter app and .NET backend.

## 📊 Database

The backend includes a comprehensive database schema with:
- User management (Students/Admins)
- Course and lesson management
- Enrollment and progress tracking
- Assignment and submission system
- File and material management

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License.

## 🆘 Support

For support and questions:
- Check the documentation in each folder
- Review the API documentation
- Open an issue on GitHub
