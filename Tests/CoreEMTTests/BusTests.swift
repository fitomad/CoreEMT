import XCTest
@testable import CoreEMT

final class TestBus: XCTestCase 
{
    /**
        -3.7069917/40.4125403/500
    */
    func testStopsAround() -> Void
    {
        let expectation = XCTestExpectation(description: "Testing Bus stops around...")
    
        EMTClient.shared.busStopsCentered(inLatitude: -3.7069917, longitude: 40.4125403, radius: 500)?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error)
                    }

                    expectation.fulfill()
                },
                receiveValue: { stops in 
                    print("# (\(#function)) Recuperadas \(stops.count) dentro del áerea")

                    XCTAssertTrue(stops.count > 0)
                }
            )
            
        self.wait(for: [ expectation ], timeout: 10.0)
    }

    func testStopDetails() -> Void
    {
        let expectation = XCTestExpectation(description: "Testing Bus stops details...")

        EMTClient.shared.busStopDetails(forBusStop: 1433)?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error.localizedDescription)
                        XCTFail(error.localizedDescription)
                    }

                    expectation.fulfill()
                },
                receiveValue: { stopDetails in 
                    print("# (\(#function)) Recuperados los detalles de la parada")
                }
            )
    
        self.wait(for: [ expectation ], timeout: 5.0)
    }

    func testArrivals() -> Void
    {
        let expectation = XCTestExpectation(description: "Testing Bus stops arrivals...")

        EMTClient.shared.arrivals(forBusStop: 1433)?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error)
                    }

                    expectation.fulfill()
                },
                receiveValue: { arrivals in 
                    print("(\(#function)) Arrivals OK... \(arrivals.count)")
                    XCTAssertTrue(arrivals.count > 0)
                }
            )

        self.wait(for: [ expectation ], timeout: 5.0)
    }

    static var allTests = [
        ("testStopsAround", testStopsAround),
        ("testStopDetails", testStopDetails),
        ("testArrivals", testArrivals)
    ]
}