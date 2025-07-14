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
    
## 📸 App Video

https://github.com/user-attachments/assets/29ba9db1-9336-41ca-ad4e-54167201b7d9

## 📸 Screenshots

<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 12 49 AM" src="https://github.com/user-attachments/assets/9d0e76bf-bf96-4a92-9550-74168165e46a" />
<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 11 51 AM" src="https://github.com/user-attachments/assets/e932f2cc-bfd9-474b-9aef-e5d52757022e" />
<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 11 35 AM" src="https://github.com/user-attachments/assets/19d0de6a-dcb7-4a4a-8ec6-fc8480000fad" />
<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 23 05 AM" src="https://github.com/user-attachments/assets/2ce82c32-9946-4eed-a45e-f00241e3146e" />
<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 23 10 AM" src="https://github.com/user-attachments/assets/3f415725-691c-40a4-8291-7f0b588d7ef7" />
<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 23 19 AM" src="https://github.com/user-attachments/assets/4282fda8-a661-49c2-af67-9e5ddb95177b" />
<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 23 23 AM" src="https://github.com/user-attachments/assets/b4676270-595a-4079-99f1-6b92229a99a4" />
<img width="250" height="497" alt="Screenshot 2025-07-14 at 10 23 31 AM" src="https://github.com/user-attachments/assets/2e2e70c1-6ee4-41d6-bfcf-94b0048aef8f" />

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

-   Adding Tests and UI Tests
