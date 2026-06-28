//
//  ListHeroesPresenterTests.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import XCTest
@testable import WallaMarvel

@MainActor
final class ListHeroesPresenterTests: XCTestCase {
    
    func test_getHeroes_whenUseCaseSucceeds_updatesUIWithCharacters() {
        
        // Given
        let expectation = expectation(description: "UI Updated")
        
        let character = CharacterDataModel.mock(name: "Rick Sanchez")
        let container = CharacterDataContainer.mock(characters: [character])
        
        let useCase = GetHeroesUseCaseMock()
        useCase.result = .success(container)
        
        let ui = ListHeroesUIMock()
        ui.onUpdate = {
            expectation.fulfill()
        }
        
        let sut = ListHeroesPresenter(getHeroesUseCase: useCase)
        sut.ui = ui
        
        // When
        sut.getHeroes(name: nil)
        
        // Then
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(ui.heroes.count, 1)
        XCTAssertEqual(ui.heroes.first?.name, "Rick Sanchez")
    }
    
    func test_getHeroes_whenUseCaseFails_updatesUIWithEmptyCharacters() {
        // Given
        let expectation = expectation(description: "UI Updated")
        
        let useCase = GetHeroesUseCaseMock()
        useCase.result = .failure(MockError.generic)
        
        let ui = ListHeroesUIMock()
        ui.onUpdate = {
            expectation.fulfill()
        }
        
        let sut = ListHeroesPresenter(getHeroesUseCase: useCase)
        sut.ui = ui
        
        // When
        sut.getHeroes(name: nil)
        
        // Then
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(ui.updateCalled)
        XCTAssertTrue(ui.heroes.isEmpty)
    }
    
    func test_getHeroes_whenSearching_passesNameAndFirstPageToUseCase() {
        // Given
        let expectation = expectation(description: "UI Updated")
        
        let useCase = GetHeroesUseCaseMock()
        useCase.result = .success(.mock())
        
        let ui = ListHeroesUIMock()
        ui.onUpdate = {
            expectation.fulfill()
        }
        
        let sut = ListHeroesPresenter(getHeroesUseCase: useCase)
        sut.ui = ui
        
        // When
        sut.getHeroes(name: "Rick")
        
        // Then
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(useCase.receivedName, "Rick")
        XCTAssertEqual(useCase.receivedPage, 1)
    }
    
    func test_loadNextPage_whenNextPageExists_requestsSecondPage() {
        let expectation = expectation(description: "UI Updated twice")
        expectation.expectedFulfillmentCount = 2
        
        let character = CharacterDataModel.mock(id: 1, name: "Rick Sanchez")
        let container = CharacterDataContainer.mock(
            characters: [character],
            pages: 2
        )
        
        let useCase = GetHeroesUseCaseMock()
        useCase.result = .success(container)
        
        let ui = ListHeroesUIMock()
        let sut = ListHeroesPresenter(getHeroesUseCase: useCase)
        sut.ui = ui
        
        var updateCount = 0
        ui.onUpdate = {
            updateCount += 1
            expectation.fulfill()
            
            if updateCount == 1 {
                sut.loadNextPage()
            }
        }
        
        sut.getHeroes(name: nil)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(useCase.receivedPages, [1, 2])
    }
}
