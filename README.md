# ListProductsProject - iOS App

A modern iOS application built with Swift and UIKit that displays a list of products with grid/list layout switching, product details, networking and API fetching.

## 🚀 Features

### Core Features
- **Products List**: Display products in both grid and list layouts
- **Layout Switching**: Toggle between grid and list views with smooth animations
- **Product Details**: Detailed view of individual products with images, ratings, and descriptions
- **Infinite Scrolling**: Load more products as user scrolls to the bottom
- **Network Monitoring**: Real-time network connectivity status monitoring
- **Error Handling**: Comprehensive error handling with user-friendly toast messages
- **Loading States**: Skeleton loading screens and activity indicators

### UI/UX Features
- **Skeleton Loading**: Custom skeleton views for better loading experience
- **Toast Notifications**: Error messages with auto-dismiss functionality
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Smooth Animations**: Layout transitions and loading animations
- **Modern UI**: iOS system colors and design patterns

## 🛠 Technology Stack & Frameworks

### Development Tools
- **Xcode**: iOS development IDE
- **SPM**: Native Dependency Manager

### Core Technologies
- **Swift Language**: Modern Swift programming language
- **UIKit (Programmatic UI)**: Framework for building the user interface
- **URLSession**: Network requests and data fetching
- **SystemConfiguration**: Network reachability monitoring
- **Swift Modern Concurrency**: asynchronous programming tool

### Third-Party Libraries
- **Kingfisher**: Image loading and caching library
- **SkeletonView**: Skeleton loading animations

## 🎯 Design Patterns

### 1. Delegate Pattern
Used for communication between components:

```swift
protocol ProductsListViewModelDelegate: AnyObject {
    func didUpdateProducts()
    func didStartLoading()
    func didStopLoading()
    func didFailLoadingProducts(withError error: String)
}
```

**Implementation Examples:**
- `ProductsListViewModelDelegate`: Communication between ViewModel and ViewController
- `ProductsCollectionViewManagerDelegate`: Collection view events handling

### 2. Singleton Pattern
Used for shared resources and global state management:

```swift
class NetworkConnectionListener {
    static let shared = NetworkConnectionListener()
    private init() { }
}
```

**Singleton Instances:**
- `NetworkConnectionListener.shared`: Network connectivity monitoring
- `NetworkLogger.shared`: Centralized network logging
- `APIConfig.shared`: API configuration management
- `Toast.shared`: Toast notification management

### 3. Adapter Pattern
Used for adapting different interfaces and data sources:

```swift
class ProductsCollectionViewManager: NSObject {
    var viewModel: ProductsListViewModel?
    weak var collectionView: UICollectionView?
    weak var delegate: ProductsCollectionViewManagerDelegate?
}
```

**Adapter Implementations:**
- `ProductsCollectionViewManager`: Adapts to any UICollectionView
- `ProductsCollectionViewAdapter+ProductsDataSource`: Data source adaptation
- `ProductsCollectionViewAdapter+ProductsDelegate`: Delegate adaptation

### 4. Protocol-Oriented Programming
Extensive use of protocols for loose coupling:

```swift
protocol APIProtocol {
    func request<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}

protocol EndpointProvider {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}
```

## 🏗 Architecture

### MVVM (Model-View-ViewModel) Architecture

The app follows the MVVM architectural pattern for clean separation of concerns:

- **View**: `ProductDetailsViewController`
- **ViewModel**: `ProductDetailsViewModel`
- **Model**: `Product`

## 📁 Project Structure

```
ListProductsProject/
├── Core/                           # Core application components
│   ├── AppDelegate/               # Application lifecycle
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Listener/                  # System listeners
│   │   └── NetworkConnectionListener.swift
│   ├── Logger/                    # Logging utilities
│   │   └── NetworkLogger.swift
│   └── Networking/                # Network layer
│       ├── APIClient.swift
│       ├── APIConfig.swift
│       ├── APIEndpoint.swift
│       ├── EndpointProvider.swift
│       ├── HTTPMethod.swift
│       └── NetworkError.swift
│
├── Features/                      # Feature modules
│   ├── ProductDetails/           # Product details feature
│   │   ├── ViewControllers/
│   │   │   └── ProductDetailsViewController.swift
│   │   └── ViewModels/
│   │       └── ProductDetailsViewModel.swift
│   │
│   └── ProductsList/             # Products list feature
│       ├── Adapters/             # Collection view adapters
│       │   ├── Extensions/
│       │   │   ├── ProductsCollectionViewAdapter+ProductsDataSource.swift
│       │   │   ├── ProductsCollectionViewAdapter+ProductsDelegate.swift
│       │   │   └── ProductsCollectionViewAdapter+SwitchLayout.swift
│       │   └── ProductsCollectionViewManager.swift
│       ├── Cells/                # Collection view cells
│       │   └── ProductCollectionViewCell.swift
│       ├── Models/               # Data models
│       │   └── ProductModel.swift
│       ├── ViewControllers/      # View controllers
│       │   ├── Components/
│       │   │   └── ProductsListSkeletonView.swift
│       │   └── ProductsListViewController.swift
│       └── ViewModels/           # View models
│           ├── DataModel/
│           │   └── Product.swift
│           └── ProductsListViewModel.swift
│
├── Shared/                       # Shared utilities
│   ├── CustomSkeletonView.swift
│   └── Toast.swift
│
├── Resources/                    # App resources
│   ├── Assets.xcassets/         # Images and colors
│   └── Base.lproj/
│       └── LaunchScreen.storyboard
│
└── Info.plist                   # App configuration
```

## 🔧 Key Components

### Network Layer
- **APIClient**: Handles HTTP requests with async/await
- **EndpointProvider**: Protocol-based endpoint configuration
- **NetworkLogger**: Comprehensive request/response logging
- **NetworkError**: Custom error handling

### UI Components
- **CustomSkeletonView**: Reusable skeleton loading component
- **Toast**: Toast notification system
- **ProductCollectionViewCell**: Adaptive cell for grid/list layouts

### Data Management
- **ProductsListViewModel**: Manages product data and pagination
- **ProductDetailsViewModel**: Handles product detail presentation
- **NetworkConnectionListener**: Monitors network connectivity

## 🚀 Getting Started

### Installation
1. Clone the repository
2. Open `ListProductsProject.xcodeproj` in Xcode
3. Build and run the project

### Dependencies
The project uses Swift Package Manager for dependencies:
- Kingfisher: Image loading and caching
- SkeletonView: Skeleton loading animations


## 📱 Screenshots

| | | | |
|----------------------|----------------------|----------------------|----------------------|
| <img src="ListProductsProject/Resources/Project%20Screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-08-28%20at%2008.08.22.png" width="200" alt="Products List - List View"> | <img src="ListProductsProject/Resources/Project%20Screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-08-28%20at%2008.08.59.png" width="200" alt="Network Error State"> | <img src="ListProductsProject/Resources/Project%20Screenshots/Simulator%20Screenshot%20-%20iPhone%20SE%20(3rd%20generation)%20-%202025-08-28%20at%2008.07.51.png" width="190" alt="Product Details View"> | <img src="ListProductsProject/Resources/Project%20Screenshots/Simulator%20Screenshot%20-%20iPhone%20SE%20(3rd%20generation)%20-%202025-08-28%20at%2008.10.01.png" width="190" alt="Products List - Grid View"> |
