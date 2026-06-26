//
//  ListHeroesPresenterTests.swift
//  WallaMarvelTests
//
//  Created by Miquel Toha Perera on 26/06/2026.
//

import XCTest
@testable import WallaMarvel

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
    
    final class GetHeroesUseCaseMock: GetHeroesUseCaseProtocol {

        var result: Result<CharacterDataContainer, Error>?

        private(set) var receivedName: String?
        private(set) var receivedPage: Int?

        func execute(
            name: String?,
            page: Int,
            completionBlock: @escaping (Result<CharacterDataContainer, Error>) -> Void
        ) {
            receivedName = name
            receivedPage = page

            guard let result else {
                return
            }

            completionBlock(result)
        }
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
}
