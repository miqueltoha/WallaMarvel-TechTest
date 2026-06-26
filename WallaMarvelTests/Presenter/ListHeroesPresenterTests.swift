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
}
