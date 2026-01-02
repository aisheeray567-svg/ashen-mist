# Firebase Setup Guide

This guide will help you configure the Firebase project **ashen-mist** (Project Number: 905749388650) for your applications.

## 1. Access Firebase Console
Go to [https://console.firebase.google.com/](https://console.firebase.google.com/) and select the project **ashen-mist**.

## 2. Web Applications Setup
You need to generate configuration keys for the web apps (`web-user` and `web-admin`).

1.  In the Project Overview, click the **Web icon (</>)** to add a new app.
2.  Register the app with the nickname **Web User**.
3.  **Copy the `firebaseConfig` object** shown on the screen. It looks like this:
    ```const firebaseConfig = {
  apiKey: "AIzaSyDDycKq_ANBKMfU-1EJaO1WDCIQ5AKWwHg",
  authDomain: "ashen-mist.firebaseapp.com",
  projectId: "ashen-mist",
  storageBucket: "ashen-mist.firebasestorage.app",
  messagingSenderId: "905749388650",
  appId: "1:905749388650:web:bed79d452307dc5d2cd913",
  measurementId: "G-R41S9XPWND"
};
    ```
4.  Repeat steps 1-3 for **Web Admin**.

> **Note**: You will need these values to update the `.env.local` files later.

## 3. Mobile Application Setup (Android)
You need to download the configuration file for the Android app.

1.  In the Project Overview, click the **Android icon** to add a new app.
2.  Enter the package name: **`com.weddingplanner`**
3.  (Optional) Enter the App nickname: **Mobile User**
4.  Click **Register app**.
5.  **Download `google-services.json`**.
6.  Move this file to the following directory in your project:
    `apps/mobile-user/app/google-services.json`

## 4. Enable Authentication
1.  Go to **Build > Authentication** in the left sidebar.
2.  Click **Get Started**.
3.  Select **Sign-in method** tab.
4.  Enable **Email/Password** and **Google** (or any other providers you need).

## 5. Enable Firestore Database
1.  Go to **Build > Firestore Database**.
2.  Click **Create Database**.
3.  Select a location (e.g., `asia-south1` or `us-central1`).
4.  Start in **Test mode** (for development) or **Production mode** (if you are ready to set rules).

---
**Once you have completed these steps, please let me know so I can proceed with the code integration.**
