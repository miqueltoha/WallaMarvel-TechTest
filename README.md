# WallaMarvel Technical Assessment

## Overview

This project was originally built on top of Marvel's public API.

Since the Marvel endpoint is currently not returning the expected payload, the application will be migrated to the Rick and Morty API while preserving the original use case: list, search and detail navigation for characters.

The Marvel API currently returns `{"message": "Internal server error"}`, so the original decoder fails because the expected `data` key is missing.

## Initial Assessment

### Crash on startup

The original implementation crashes when decoding the API response because it relies on:

- `try!`
- force unwrapping (`!`)

When the Marvel API does not return the expected schema, the application terminates with a decoding error (`keyNotFound`).

### Architecture

- Networking layer is tightly coupled to the Marvel API response schema.
- Error handling is currently missing.
- APIClient directly exposes Marvel-specific models.

## Implementation Plan

- [ ] Replace Marvel API with Rick and Morty API
- [ ] Improve networking error handling
- [ ] Add unit tests
- [ ] Implement character detail screen
- [ ] Implement pagination
- [ ] Implement search
- [ ] Review accessibility support
