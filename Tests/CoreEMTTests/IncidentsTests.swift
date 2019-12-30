import XCTest
@testable import CoreEMT

final class IncidentsTests: XCTestCase 
{
    func testAllIncidents() -> Void
    {
        let expectation = XCTestExpectation(description: "Incidencias en todas las líneas, si las hay...")

        let publisher = EMTClient.shared.busServiceIncidents()?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error.localizedDescription)
                        XCTFail(error.localizedDescription)
                    }

                    expectation.fulfill()
                },
                receiveValue: { incidents in 
                    print("#(\(#function)) Incidencias en el servicio: \(incidents.count)")
                    XCTAssertFalse(incidents.isEmpty)
                }
            )

        self.wait(for: [ expectation ], timeout: 10.0)
    }

    func testIncidentsForLine() -> Void
    {
        let expectation = XCTestExpectation(description: "Incidencias en todas las líneas, si las hay...")

        let publisher = EMTClient.shared.busServiceIncidents(forLine: 18)?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error.localizedDescription)
                        XCTFail(error.localizedDescription)
                    }

                    expectation.fulfill()
                },
                receiveValue: { incidents in 
                    print("#(\(#function)) Incidencias en el servicio para una línea: \(incidents.count)")
                    XCTAssertFalse(incidents.isEmpty)
                }
            )

        self.wait(for: [ expectation ], timeout: 10.0)
    }

    /// Los tests que ejecutamos sobre las incidencias en el servicio
    static var allTests = [
        ("testAllIncidents", testAllIncidents),
        ("testIncidentsForLine", testIncidentsForLine)
    ]
}