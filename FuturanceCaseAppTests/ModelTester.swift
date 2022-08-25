//
//  ModelTester.swift
//  FuturanceCaseAppTests
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import XCTest
@testable import FuturanceCaseApp

class ModelTester: XCTestCase {
    func singleModelTest() throws {
        let bundle = Bundle(for: ModelTester.self)
        guard let url = bundle.url(forResource: "single", withExtension: "json") else {throw TestError.emptyURL }
        let data = try Data(contentsOf: url)
        let decoder = Decoders.plainDecoder
        let decoded = try decoder.decode(Currency.self, from: data)
        XCTAssertEqual(decoded.symbol, "ETHBTC")
    }
}
enum TestError: Error {
    case emptyURL
}
