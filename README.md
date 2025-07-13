# 🎵 Music Log

A native SwiftUI app to reflect on the music you're listening to — by logging moods, notes, and moments that tracks spark.

Building this to explore SwiftUI deeply, with an architecture that’s clean, modular, and designed to scale.

----------

## ✨ Features

-   Spotify login with PKCE flow
    
-   Now Playing + Recently Played (via Spotify API)
    
-   Multi-detent sheet to log moods, notes, and more
    
-   Beautiful logbook UI with animations & matched transitions
    
-   Offline-friendly with SwiftData persistence
    
-   Shimmer loading, chip UI, and theme-aware design
    
-   Modular folder-by-feature structure
    

----------

## 📸 Screenshots

----------

## 🧱 Tech Stack

-   `SwiftUI`  +  `@Observable`
    
-   `SwiftData`  (for local logs)
    
-   Modular  `MVVM`  architecture
    
-   Spotify Web API
    
-   Reusable custom components
    
-   Custom theming with color assets
    
-   Async image loading, matched geometry, haptics
    
----------

## 🗂 Folder Structure

```
`Music Log/
├── App/
│   ├── AppEnvironment.swift
│   ├── AppTheme.swift
│   └── Root/
├── Core/
│   ├── Auth/
│   ├── DesignSystem/
│   ├── Error/
│   ├── Extensions/
│   ├── Keyboard/
│   ├── Models/
│   ├── Networking/
│   ├── Persistence/
│   └── ViewModifiers/
├── Features/
│   ├── Home/
│   ├── Logs/
│   └── Profile/
├── Resources/
│   ├── Assets.xcassets
│   ├── Colors.xcassets
│   └── Fonts/
└── README.md
```

Everything is structured to reflect real-world complexity while staying clean and readable. Features live in  `Features/`, shared utilities and styling in  `Core/`.

----------

## 🏃‍♀️ Getting Started

1.  Clone the repo
    
2.  Open  `Music Log.xcodeproj`
    
3.  Add your Spotify client credentials in SpotifyAuthEndpoints
    
4.  Run on iOS 18+

----------
## 📌 Notes

-   Uses PKCE flow for secure Spotify auth
    
-   Offline logging is supported with SwiftData
    
-   Fully responsive UI using native SwiftUI components
    
-   Typography uses Lato & Montserrat (bundled locally)

----------

## 🚧 Roadmap

-   iCloud backup for logs
    
-   Search and add logs
    
-   Interactive Insights
