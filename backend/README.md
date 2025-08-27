# E-Learning Platform Backend API

A comprehensive .NET 9 Web API backend for the E-Learning Platform.

## 🚀 Technology Stack

- **.NET 9** - Latest LTS version
- **Entity Framework Core** - ORM with SQL Server
- **ASP.NET Core Identity** - User management and authentication
- **JWT Authentication** - Secure API access
- **AutoMapper** - Object mapping
- **Swagger/OpenAPI** - API documentation

## 📁 Project Structure

```
backend/
├── Controllers/           # API Controllers
│   ├── AuthController.cs  # Authentication endpoints
│   └── CoursesController.cs # Course management
├── Models/               # Entity models
│   ├── ApplicationUser.cs
│   ├── Course.cs
│   ├── Lesson.cs
│   ├── Enrollment.cs
│   ├── LessonProgress.cs
│   ├── Assignment.cs
│   ├── AssignmentSubmission.cs
│   └── CourseMaterial.cs
├── Data/                 # Database context
│   └── ApplicationDbContext.cs
├── DTOs/                 # Data Transfer Objects
│   ├── RegisterDto.cs
│   ├── LoginDto.cs
│   ├── CreateCourseDto.cs
│   └── UpdateCourseDto.cs
├── Services/             # Business logic services
└── Program.cs           # Application entry point
```

## 🔧 Setup Instructions

### Prerequisites
- .NET 9 SDK
- SQL Server (or SQLite for development)

### Installation

1. **Navigate to the backend directory:**
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

4. **Run the application:**
   ```bash
   dotnet run
   ```

### Database Setup

1. **Create initial migration:**
   ```bash
   dotnet ef migrations add InitialCreate
   ```

2. **Update database:**
   ```bash
   dotnet ef database update
   ```

## 🌐 API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login

### Courses
- `GET /api/courses` - List all courses (with filtering)
- `GET /api/courses/{id}` - Get course details
- `POST /api/courses` - Create new course (Admin/Instructor)
- `PUT /api/courses/{id}` - Update course (Owner only)
- `DELETE /api/courses/{id}` - Delete course (Owner only)

## 🔐 Authentication

The API uses JWT (JSON Web Tokens) for authentication. Include the token in the Authorization header:

```
Authorization: Bearer <your-jwt-token>
```

## 📊 Database Schema

The backend includes a complete database schema with:
- **Users** (Students/Admins) with extended profile information
- **Courses** with lessons, materials, and assignments
- **Enrollments** and progress tracking
- **Assignments** and student submissions
- Proper relationships and constraints

## 🛠️ Development

### Adding New Controllers
1. Create a new controller in the `Controllers/` folder
2. Add corresponding DTOs in the `DTOs/` folder
3. Update the database context if needed
4. Add any required services

### Adding New Models
1. Create the model in the `Models/` folder
2. Add it to the `ApplicationDbContext`
3. Create and run migrations
4. Update related controllers and DTOs

## 🔧 Configuration

Update `appsettings.json` to configure:
- Database connection string
- JWT settings
- Logging levels

## 📚 API Documentation

Once the application is running, visit:
- **Swagger UI:** `https://localhost:7000/swagger`
- **API Base:** `https://localhost:7000/api`

## 🚀 Deployment

The backend is ready for deployment to:
- Azure App Service
- AWS Elastic Beanstalk
- Docker containers
- Any .NET hosting platform

## 📝 License

This project is part of the E-Learning Platform.
