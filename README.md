# EduApp - E-Learning-Platform 🧑‍🏫📚

## Overview
<div style="text-align: justify">
This project is an E-Learning mobile application built using Flutter for the front end and Go for the back end. The application provides distinct functionalities for two types of users: Admin and Student. It features a robust authentication system, course management, and user management, with Super Admin capabilities to oversee the entire system.</div>

## Features

### For Students:
📝 **User Registration and Login**: Students can register and log in to the application. Upon registration, a request is sent to the Admin for approval.<br/>
🎓 **Course Enrollment**: Students can browse available courses and send enrollment requests. Access to course resources is granted upon Admin approval.<br/>
🛠️ **Profile Management**: Students can edit their personal details.

### For Admins:
👥 **User Management**: Admins can accept or reject student registration requests and enrollment requests.<br/>
📚 **Course Management**: Admins can add, edit, and delete courses, as well as manage course resources and assignments.<br/>
🧑‍🎓 **Student Management**: Admins can manage student details and remove students if necessary.<br/>

### For Super Admin:
🛡️ **Admin Management**: Super Admins can add new Admins and manage existing Admins.<br/>
👑 **System Oversight**: Super Admins have access to all functionalities available to Admins and can oversee the entire system.

## Tech Stack
📱 **Frontend**: Flutter<br/>
💻 **Backend**: Go

## Installation
### Prerequisites
🚀 **Flutter SDK**: Flutter Installation Guide<br/>
🛠️ **Go**: Go Installation Guide

### Backend Setup
**Clone the repository**:
git clone https://github.com/yourusername/elearning-app.git<br/>
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
📝 Students register through the app.<br/>
✔️ Admin reviews and approves the registration request.<br/>
📚 Students can browse courses and send enrollment requests.<br/>
✔️ Admin approves the enrollment request, granting access to course resources.<br/>

### Admin Management:
🔑 Admins can log in to the system.<br/>
👥 Manage student requests and course content.<br/>
👑 Super Admins can add new Admins and manage existing ones.

## Contributing
We welcome contributions to enhance the functionality and features of this E-Learning app. 

**To contribute**:<br/>
🍴 Fork the repository.<br/>
🌿 Create a new branch.<br/>
🔧 Make your changes.<br/>
📨 Submit a pull request.


## Contact
For any questions or suggestions, feel free to reach out to us at 📧 dulajupananda@gmail.com.
