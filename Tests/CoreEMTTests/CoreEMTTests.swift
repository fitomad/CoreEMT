import XCTest
@testable import CoreEMT

final class CoreEMTTests: XCTestCase 
{
    /**

    */
    func testLogin() -> Void
    {
        let expectation = XCTestExpectation(description: "Testing Login...")
    
        let publisher = EMTClient.shared.login()?
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error.localizedDescription)
                    }

                    expectation.fulfill()
                },
                receiveValue: { apiUser in 
                    EMTClient.shared.accessToken = apiUser.accessToken
                    print("# (\(#function)) Token: \(apiUser.accessToken)")
                    XCTAssertFalse(apiUser.accessToken.isEmpty)
                }
            )

        self.wait(for: [ expectation ], timeout: 10.0)
    }

    static var allTests = [
        ("testLogin", testLogin)
    ]
}
