//
//  ProductListUseCaseTests.swift
//  ProductCatalogTests
//
//  Created by Ahmed Ashraf on 29/01/2026.
//

import XCTest
import Combine
@testable import ProductCatalog

final class ProductListUseCaseTests: XCTestCase {
    
    var sut: ProductListUseCase!
    var mockRepo: MockProductListRepo!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockProductListRepo()
        sut = ProductListUseCase(repo: mockRepo)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        mockRepo = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchProductsShouldCallRepo() {
        mockRepo.result = .success([])
        _ = sut.fetchProducts(numberOfProducts: 10)
        XCTAssertEqual(mockRepo.fetchCallCount, 1)
        XCTAssertEqual(mockRepo.lastRequestedCount, 10)
    }
    
    func testFetchProductsWhenRepoSucceedsShouldReturnProducts() {
        let expectation = expectation(description: "Products received")
        let mockProducts = [
            Product(id: 1, title: "Product 1", price: 120, description: "Product Description 1", category: "Product category 1", image: "Product image 1", rating: .init(rate: 5, count: 300)),
            Product(id: 2, title: "Product 2", price: 120, description: "Product Description 2", category: "Product category 2", image: "Product image 2", rating: .init(rate: 5, count: 300)),
            Product(id: 3, title: "Product 3", price: 120, description: "Product Description 3", category: "Product category 3", image: "Product image 3", rating: .init(rate: 5, count: 300))
        ]
        mockRepo.result = .success(mockProducts)
        
        var receivedProducts: [Product]?
        
        sut.fetchProducts(numberOfProducts: 3)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { products in
                    receivedProducts = products
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedProducts?.count, 3)
        XCTAssertEqual(receivedProducts?.first?.id, 1)
        XCTAssertEqual(receivedProducts?.last?.id, 3)
    }
    
    func testFetchProductsWhenRepoFailsShouldReturnError() {
        let expectation = expectation(description: "Error received")
        mockRepo.result = .failure(.invalidResponse)
        
        var receivedError: NetworkError?
        
        sut.fetchProducts(numberOfProducts: 5)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(receivedError)
    }
}

// MARK: - Mock Repository

final class MockProductListRepo: ProductListRepoInterface {
    var result: Result<[Product], NetworkError>?
    var fetchCallCount = 0
    var lastRequestedCount: Int?
    
    func fetchProducts(numberOfProducts: Int) -> AnyPublisher<[Product], NetworkError> {
        fetchCallCount += 1
        lastRequestedCount = numberOfProducts
        
        guard let result = result else {
            return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
        }
        
        return result.publisher.eraseToAnyPublisher()
    }
}
