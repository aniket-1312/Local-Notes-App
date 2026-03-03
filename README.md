# 📱 Flutter Notes App – Local Storage Project

## 🎥 Project Demonstration Video

Watch the complete working demo here:

👉 **Google Drive Link:**  
https://drive.google.com/file/d/1Z3sHbyv2ClLo2gYV77NmNzHR2ORQIOGB/view?usp=sharing

---

## 📌 Project Overview

This project is a Flutter-based Notes Application that demonstrates local data storage using **SharedPreferences**.

The application allows users to:

- ✅ Add Notes
- ✅ Edit Notes
- ✅ Delete Notes
- ✅ Enable / Disable Dark Mode
- ✅ Store Data Permanently (Local Storage)

All data is stored locally on the device without using any online database.

---

## 🛠 Technologies Used

- Flutter
- Dart
- SharedPreferences
- Material UI

---

## 📂 Features Implemented

### ⭐ 1. Add Note
User can create a new note with title and description.

### ✏ 2. Edit Note
Existing notes can be modified.

### 🗑 3. Delete Note
User can delete notes with confirmation dialog.

### 🌙 4. Dark Mode
User can switch between Light and Dark theme.
Theme preference is saved permanently.


---

## 💾 Storage Mechanism

SharedPreferences is used for storing notes in key-value format.

Since SharedPreferences does not directly support objects:
- Notes are converted into JSON format before saving.
- JSON is decoded back into objects when loading.

---
## ScreenShot


<img width="388" height="759" alt="Screenshot 2026-03-03 at 4 43 27 PM" src="https://github.com/user-attachments/assets/c07d3e46-ed30-40d6-9982-5322fc7303c4" />
<img width="346" height="750" alt="Screenshot 2026-03-03 at 4 43 53 PM" src="https://github.com/user-attachments/assets/d2b67986-936e-43b3-87d9-6ad90755135d" />
<img width="353" height="755" alt="Screenshot 2026-03-03 at 4 44 19 PM" src="https://github.com/user-attachments/assets/ce91ce8c-89df-4d30-b834-7c15b17aa183" />
<img width="361" height="756" alt="Screenshot 2026-03-03 at 4 44 34 PM" src="https://github.com/user-attachments/assets/0e988db8-bd6a-4c3b-ab71-2ee9ca8be7bc" />
<img width="369" height="752" alt="Screenshot 2026-03-03 at 4 45 59 PM" src="https://github.com/user-attachments/assets/ba5922b0-7163-4d04-9c43-90c0b014c832" />



