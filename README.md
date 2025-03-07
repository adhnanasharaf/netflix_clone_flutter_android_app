# 📺 Flutter Netflix Clone

A Flutter-based Netflix clone that uses the TMDB (The Movie Database) API to display movies, trending content, and TV shows dynamically.

## 🚀 Features
- Fetches movie & TV show data from TMDB API
- Displays trending, popular, and top-rated movies
- Movie details screen with description, rating, and poster
- Search functionality to find movies & TV shows
- Smooth UI with Flutter widgets

## 🛠️ Tech Stack
- **Flutter** (Dart)
- **TMDB API** (for fetching movie data)
- **HTTP Package** (for API requests)

## 🔧 Setup & Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter-netflix-clone.git
   cd flutter-netflix-clone
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Get a TMDB API key:
   - Sign up at [TMDB](https://www.themoviedb.org/)
   - Generate an API key in [API Settings](https://www.themoviedb.org/settings/api)

4. Add your API key in `lib/services/api_service.dart`:
   ```dart
   class ApiService {
     static const String apiKey = 'YOUR_API_KEY';
     static const String baseUrl = 'https://api.themoviedb.org/3';
   }
   ```

5. Run the app:
   ```bash
   flutter run
   ```

## 🖼️ Screenshots
Coming soon!

## 📌 API Endpoints Used
- **Popular Movies:** `/movie/popular`
- **Trending Movies:** `/trending/movie/week`
- **Movie Details:** `/movie/{movie_id}`
- **Search:** `/search/movie`

## 🤝 Contribution
Feel free to fork this repo, raise issues, and submit PRs!

## 📜 License
This project is licensed under the MIT License. 🎬
