# WeatherApp

## Introduction
WeatherApp is built using **MVVM combined with CLEAN architecture principles**, following the **SOLID principles** to ensure the project is **scalable, testable, and maintainable**.  
The app consumes weather data using **WeatherAPI**.

---

## Architecture Overview
The project follows **CLEAN architecture layered approach** along with **MVVM** for presentation.  
Each layer has a **clear responsibility** and depends only on abstractions, not concrete implementations.

---

### Folder Structure

WeatherApp/
│
├── WeatherAppApp.swift        # Application entry point (App Layer)
│
├── Common/                    # Shared resources and utilities
│   ├── AppStrings.swift
│   ├── DI/AppDIContainer.swift
│   └── Extensions/String+Extension.swift
│
├── Data/                      # Data Layer
│   ├── DataSource/WeatherDataSource.swift
│   ├── DataSource/Network/
│   │   ├── APIClient.swift
│   │   ├── WeatherAPIEndpoints.swift
│   │   ├── WeatherAPIService.swift
│   │   └── APIConfig.swift
│   ├── Repository/WeatherRepositoryImpl.swift
│   ├── Mapper/WeatherResponse+Mapper.swift
│   └── Models/WeatherResponse.swift
│
├── Domain/                    # Domain Layer
│   ├── Repository/WeatherRepository.swift
│   ├── Models/WeatherReport.swift
│   └── UseCase/GetWeatherUseCase.swift
│
└── Presentation/              # Presentation Layer 
    └── ViewModels/WeatherViewModel.swift
    └── Models/WeatherUIModel.swift
    └── Mapper/WeatherReport+UIMapper.swift
    └── Views
        └── WeatherView.swift
        └── Components

---
    
### Layer Responsibilities
- **App Layer** → Application entry point.  
- **Common Layer** → Dependency Injection, shared constants, and extensions.  
- **Data Layer** → Handles networking, API services, repository implementations, DTOs, and mapping.  
- **Domain Layer** → Defines models, repository protocols, and use cases (business logic).  
- **Presentation Layer (MVVM)** → ViewModels handle UI state and call UseCases.
  
This separation ensures that **UI changes won’t affect business logic**, and **data sources can be swapped** without changing higher layers.

---

## 🔄 Communication Between Layers
- **Presentation → Domain**: ViewModels call UseCases.  
- **Domain → Data**: UseCases depend on Repository interfaces.  
- **Data → Domain**: Data layer implements Repository protocols and maps Response models to Domain models.  
- **Dependency Injection** ensures each layer gets its dependencies via protocols, not direct concrete implementations.  

---

## SOLID Principles in Action

### 1. Single Responsibility Principle
Each class has a **single responsibility**.  
- 'WeatherResponse+Mapper.swift' → only maps API models to Domain models.  
- 'WeatherRepositoryImpl.swift' → only fetches and provides weather data.  

extension WeatherResponse {
    func toDomain() -> WeatherReport {
        return WeatherReport(
            city: location.name,
            localtime: location.localtime,
            temperature: current.temp_c,
        )
    }
}
👉 This makes the code clean, reusable, and testable.

### 2. Open/Closed Principle
Classes are open for extension, closed for modification.
WeatherRepository is defined as a protocol.
Current implementation: WeatherRepositoryImpl fetches current weather.
New implementation: ForecastWeatherRepositoryImpl could fetch forecasts without modifying existing code.

protocol WeatherRepository {
    func getWeather(for city: String) async throws -> WeatherReport
}

👉 You can extend the app by adding new repositories or use cases without changing existing ones.
This makes the codebase future-proof.

### 3. Liskov Substitution Principle
WeatherRepositoryImpl conforms to WeatherRepository.
In tests, MockWeatherRepository can replace it.

class MockWeatherRepository: WeatherRepository {
    var mockReport: WeatherReport?
    
    func getWeather(for city: String) async throws -> WeatherReport {
        return mockReport ?? WeatherReport(city: city, temperature: 25, condition: "Sunny")
    }
}

Any implementation of a protocol can be substituted without breaking the system.
👉 This makes testing seamless and ensures flexibility.

### 4. Interface Segregation Principle
Protocols are kept minimal and specific.
WeatherRepository only exposes weather-related methods, keeping the contract minimal and clear:

protocol WeatherRepository {
    func getWeather(for city: String) async throws -> WeatherReport
}

👉 This ensures the UseCase depends only on the specific methods it needs from the repository, and are not forced to depend on unused methods.
Interfaces are **clean and lightweight**, making the code **maintainable**.

### 5. Dependency Inversion Principle
No modules depend directly on each other — they communicate via protocols.
Constructor Injection ensures layers only depend on abstractions.

final class WeatherViewModel: ObservableObject {
    private let getWeatherUseCase: GetWeatherUseCase
    
    init(getWeatherUseCase: GetWeatherUseCase) {
        self.getWeatherUseCase = getWeatherUseCase
    }
}

GetWeatherUseCase depends on WeatherRepository (protocol), not WeatherRepositoryImpl.
Dependencies are wired in AppDIContainer.swift.
👉 This makes the app decoupled, scalable, and testable.


## Testing Approach
The project includes both Unit Tests and UI Tests, organized in separate folders.

### Unit Tests (WeatherAppTests/)
 - Unit tests are conducted for components within all layers of the architecture.
 - Example: Verify GetWeatherUseCase correctly calls the repository.
 - Uses MockWeatherRepository to isolate tests from the network.

func test_GetWeatherUseCase_ReturnsReport() async throws {
    let mockRepo = MockWeatherRepository()
    mockRepo.mockReport = WeatherReport(city: "Sydney", temperature: 22, condition: "Cloudy")
    let useCase = GetWeatherUseCase(repository: mockRepo)
    
    let result = try await useCase.getWeather(city: "Sydney")
    
    XCTAssertEqual(result.city, "Sydney")
}
👉 This ensures fast, reliable tests without hitting real APIs.

### UI Tests (WeatherAppUITests/)
 - Focus on end-to-end flows.
 - Example: Launch app → search for city → verify weather details appear.
 - Uses XCUIApplication for UI interactions.
👉 Ensures the app works correctly from a user’s perspective.

## Conclusion
The WeatherApp is structured with **CLEAN architecture + MVVM** and adheres to **SOLID principles**.  
This ensures the codebase is **easy to maintain, extend, and test**.
