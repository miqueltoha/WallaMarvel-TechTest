# WallaMarvel Technical Assessment

## Overview

This project was originally built on top of Marvel's public API.

At the time of implementation, the Marvel endpoint was consistently returning:

```json
{"message": "Internal server error"}
```

Because the application relied on the Marvel response schema, it crashed while decoding the response.

To keep the original user experience and complete the assessment, the networking layer was migrated to the Rick and Morty API while preserving the existing architecture and application flow.

---

## Initial Assessment

### Crash on startup

The original implementation crashed during decoding because it relied on:

* `try!`
* Force unwrapping (`!`)

When the Marvel API returned an unexpected payload, the application terminated with a `DecodingError`.

### Architecture observations

* Networking layer tightly coupled to the Marvel response model.
* No networking error handling.
* Unsafe decoding.
* No automated tests.

---

## Implemented Changes

* ✅ Replaced the Marvel API with the Rick and Morty API.
* ✅ Migrated the networking layer to Swift Concurrency (`async/await`).
* ✅ Adopted Swift 6 concurrency (`@MainActor`, `Sendable`).
* ✅ Removed force unwrapping and `try!`.
* ✅ Added proper HTTP and decoding error handling.
* ✅ Implemented Character Detail screen.
* ✅ Implemented the Character Detail screen using SwiftUI while keeping the rest of the application in UIKit.
* ✅ Added character search.
* ✅ Added infinite pagination.
* ✅ Added image placeholders for missing resources.
* ✅ Added Presenter unit tests using mocks.

---

## Architecture

The existing MVP + Clean Architecture has been preserved.

The project follows a layered approach:

* Presentation
* Domain (Use Cases)
* Repository
* Data Source
* API Client

Dependencies are injected through protocols to improve testability.

The networking flow has been modernized using Swift Concurrency while keeping the original architectural boundaries intact.

---

## Testing

Unit tests cover the Presenter behaviour using mocked dependencies.

Covered scenarios include:

* Successful character loading
* Error handling
* Character search
* Pagination
* Presenter interaction with the UI

Mocks isolate the Presenter from the networking and UI layers.

---

## SwiftUI

The Character Detail screen has been implemented in SwiftUI and integrated into the existing UIKit navigation flow using `UIHostingController`.

This demonstrates interoperability between UIKit and SwiftUI while following a progressive migration strategy.

---

## Possible Future Improvements

* Pull-to-refresh.
* Offline persistence.
* Image prefetching.
* Snapshot/UI tests.
* Accessibility improvements.
* Complete migration of the presentation layer to SwiftUI.

---

## Notes

The goal of this implementation was to preserve the original project structure while significantly improving robustness, modernizing the networking layer, increasing testability and implementing the requested features with minimal architectural impact.

## Decisions

Rather than replacing the existing architecture, I chose to preserve the original MVP + Clean Architecture and modernize it incrementally by introducing Swift Concurrency, improving error handling, adding unit tests and integrating SwiftUI where it provided the greatest value.
