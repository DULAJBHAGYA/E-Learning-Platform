# EduApp - E-Learning-Platform 🧑‍🏫📚

## Overview
This project is an E-Learning mobile application built using **Flutter** for the front end and **Go** for the back end. The application provides distinct functionalities for two types of users: Admin and Student. It features a robust authentication system, course management, and user management, with Super Admin capabilities to oversee the entire system.

## Features

### For Students:
📝 **User Registration and Login**: Students can register and log in to the application. Upon registration, a request is sent to the Admin for approval.
🎓 **Course Enrollment**: Students can browse available courses and send enrollment requests. Access to course resources is granted upon Admin approval.
🛠️ **Profile Management**: Students can edit their personal details.

### For Admins:
👥 **User Management**: Admins can accept or reject student registration requests and enrollment requests.
📚 **Course Management**: Admins can add, edit, and delete courses, as well as manage course resources and assignments.
🧑‍🎓 **Student Management**: Admins can manage student details and remove students if necessary.

### For Super Admin:
🛡️ **Admin Management**: Super Admins can add new Admins and manage existing Admins.
👑 **System Oversight**: Super Admins have access to all functionalities available to Admins and can oversee the entire system.

## Tech Stack
📱 **Frontend**: Flutter
💻 **Backend**: Go

## Installation
### Prerequisites
🚀 **Flutter SDK**: Flutter Installation Guide
🛠️ **Go**: Go Installation Guide

### Backend Setup
**Clone the repository**:
git clone https://github.com/yourusername/elearning-app.git
cd elearning-app/backend

**Install dependencies**:
go mod tidy

**Run the backend server**:
go run main.go

### Frontend Setup
**Navigate to the frontend directory**:
cd elearning-app/frontend

**Install dependencies**:
flutter pub get

**Run the app**:
flutter run

## Usage

### Student Registration and Enrollment:
📝 Students register through the app.
✔️ Admin reviews and approves the registration request.
📚 Students can browse courses and send enrollment requests.
✔️ Admin approves the enrollment request, granting access to course resources.

### Admin Management:
🔑 Admins can log in to the system.
👥 Manage student requests and course content.
👑 Super Admins can add new Admins and manage existing ones.

## Contributing
We welcome contributions to enhance the functionality and features of this E-Learning app. 

**To contribute**:
🍴 Fork the repository.
🌿 Create a new branch.
🔧 Make your changes.
📨 Submit a pull request.


## Contact
For any questions or suggestions, feel free to reach out to us at 📧 dulajupananda@gmail.com.
