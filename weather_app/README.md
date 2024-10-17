## Weather App Documentation

# Introduction

This project is a weather app that uses the OpenWeatherMap and Google Places APIs to display weather information for selected cities.

# Technologies Used

    -Flutter for mobile app development.
    -Node.js for backend API handling.
    -APIs: OpenWeatherMap, Google Places (managed via Node.js backend).

# Prerequisites

**Ensure you have the following installed:**

    Flutter SDK
    Node.js
    Git

# Getting Started

**Clone the Repository.**

**Install Node.js dependencies:**

`npm install axios cors dotenv express`

**Navigate to the weather_app/backend folder**
`cd weather_app/backend`

**Start the Node.js server on git bash:**

`npm start`

The backend server will run on http://localhost:3000.

# Running the Flutter App

**Open another terminal(command prompt) and navigate to the weather_app directory:**
    `cd weather_app`

**Install Flutter dependencies:**
    `flutter pub get`

**Launch the app:**
    `flutter run`

# Troubleshooting

Backend Issues: Ensure Node.js is running in git bash and is accessible.
Flutter Issues: Ensure Flutter dependencies are installed and the app is launched using flutter run on cmd.

# Notice

**The provided APIs are for testing purposes and thus only available for a short period and will be deactivated right after in anticipation of deployment where new keys will be generated.**

# Support

For any issues or questions, please contact o.rabuthu@gmail.com.