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

When the Marvel API returned an unexpected payload, the application terminated with a `DecodingError.keyNotFound`.

### Architecture observations

* Networking layer tightly coupled to the Marvel response model.
* No networking error handling.
* Unsafe decoding.
* No automated tests.

---

## Implemented Changes

* ✅ Replaced the Marvel API with the Rick and Morty API.
* ✅ Introduced safe networking using `Result`.
* ✅ Removed force unwrapping and `try!`.
* ✅ Added proper HTTP and decoding error handling.
* ✅ Implemented Character Detail screen.
* ✅ Added character search.
* ✅ Added infinite pagination.
* ✅ Added Presenter unit tests using mocks.

---

## Architecture

The existing architecture has been preserved.

The project follows a layered approach:

* Presentation
* Domain (Use Cases)
* Repository
* Data Source
* API Client

Dependencies are injected through protocols to improve testability.

---

## Testing

Unit tests have been added for the Presenter covering:

* Successful character loading
* Error handling
* Character search
* Pagination flow

Mocks are used for the Use Case and UI layers to isolate Presenter behaviour.

---

## Possible Future Improvements

* Loading indicator during pagination.
* Dedicated empty and error states.
* APIClient unit tests.
* Image placeholders and retry strategy.
* Accessibility improvements.

## Notes

The goal of this implementation was to preserve the original project structure while improving robustness, testability and functionality with the minimum architectural impact.

## Decisions

I decided to preserve the existing MVP + Clean Architecture instead of replacing it with another architecture because I considered it more valuable to improve robustness, testability and requested features while minimizing unnecessary structural changes.

## Concurrency

The project currently keeps the original callback-based networking approach to preserve the existing architecture and minimize unnecessary changes.

A future improvement would be migrating the networking layer and use cases to Swift Concurrency (`async/await`) and enabling strict concurrency checks once the architecture boundaries are fully adapted.
