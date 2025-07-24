# 🛒 Product List App with Cart and User Authentication

## 📋 Technical Task Overview

A Flutter application that displays a list of products from a public API, allows users to manage a shopping cart, and supports user registration and login using Firebase Authentication.

---

## 🚀 Features

### 🧾 Product List

- Fetches products from [`https://dummyjson.com/products`](https://dummyjson.com/products)
- Displays:
  - Product name
  - Product image
  - Short description
  - Product price
  - "Add to Cart" button
- Includes sorting & filtering options (e.g., by price, category)
- View product details via a dedicated detail page

### 🛒 Cart

- Add products to cart
- Increase/decrease item quantities
- Remove individual items
- Cart screen:
  - Shows all added items
  - Displays total price

### 🔐 User Authentication (via Firebase)

- Register and Login functionality
- Guest users can use the app but must register/login at checkout

### 💡 UI & UX

- Simple and attractive design
- Harmonious color scheme and readable fonts
- Responsive error and loading state handling

---

## 🧠 State Management

- Built using **Cubit** or **BLoC** for scalable and maintainable state handling

---

## 📦 Submission

- Installable APK
- Complete project source code

---

## 📌 Additional Notes

- Prevent adding zero or negative quantities
- Notify users when a product is added to cart
- Guests see different UI and are prompted to log in at checkout
