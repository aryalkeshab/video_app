# Video Feed App

## Project Overview

This project is a mobile application designed to provide a vertically scrollable video feed with user interaction features like authentication, comments, sharing, and state management. The app ensures a clean UI/UX and supports modular state management with Riverpod.

---

## Features

### 1. User Authentication

- **Registration & Login**:
  - Supports registration and login using Firebase Authentication.
  - Allows users to sign in with email-password or Google.
- **Forgot Password**:
  - Users can reset their password via Firebase's password reset functionality.
- **Navigation**:
  - On successful login, users are navigated to the homepage.

---

### 2. Video Feed

- **Scrollable Feed**:
  - Displays 20-30 static video links in a vertically scrollable list.
- **Playback Behavior**:
  - Each video takes up the full screen and plays when in focus.
  - Only one video plays at a time.
- **Pause/Play**:
  - Users can pause and resume videos.

---

### 3. UI Elements

Each video includes:

1. **Comment Button**:
   - Opens a modal or page to view and post comments.
2. **Share Button**:
   - Opens the system’s share dialog with the video link as shareable content.
3. **Like/Unlike Button**:
   - Allows users to like or unlike a video.

---

### 4. Comment Feature

- **Comment Page**:
  - A modal or page for users to type and send comments.
- **Bot Interaction**:
  - If no new comment is typed within 5 seconds after sending a comment, a bot automatically posts a random comment.
  - Bot-generated comments are tied to the respective video.
- **Storage**:
  - Comments (user and bot) are stored locally using Hive, a lightweight NoSQL database.
- **Persistence**:
  - Comments persist and can be retrieved when the app is reopened.

---

### 5. Share Feature

- **Native Sharing**:
  - Clicking the Share button opens the device's native share dialog.
  - The video link is included in the shared content.

---

### 6. State Management

- **GetX**:
  - Modular state management using Getx ensures efficient and maintainable state handling.

---

### 7. UI/UX Considerations

- **Responsive Design**:
  - Supports various screen sizes and resolutions.
- **Clean Layout**:
  - User-friendly and intuitive interface design.

---

## Extra Features

- **Like/Unlike**:
  - Users can like or unlike videos, and their preference is saved.
- **Pause/Play**:
  - Videos can be paused and resumed manually.
- **Forgot Password**:
  - Firebase's password reset functionality for registered users.
- **Profile Management**:
  - Users can view their profile.

---

## Tech Stack

- **Frontend**: Flutter
- **Backend**: Firebase Authentication
- **Database**: Hive (for local storage)
- **State Management**: GetX

---

## How to Run the App

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/videofeedapp.git
   cd videofeedapp

   ```

2. Install dependencies
   flutter pub get
3. Run the app
   flutter run
