import XCTest
@testable import CoreEMT

final class EMTBicimadTests: XCTestCase 
{
    /** 
        Recuperamos todas las estaciones de Bicimad
    */
    func testStations() -> Void
    {
        let expectation = XCTestExpectation(description: "Bicimad Stations (list)...")

        let publisher = EMTClient.shared.bicimadStations()?
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {                        
                        print(error.localizedDescription)
                        XCTFail(error.localizedDescription)  
                    }

                    expectation.fulfill()
                },
                receiveValue: { stations in 
                    print("# (\(#function)) Estaciones disponibles: \(stations.count)")

                    XCTAssertFalse(stations.isEmpty)
                }
            )

        self.wait(for: [ expectation ], timeout: 10.0)
    }

    /** 
        Recuperamos una estación de Bicimad
    */
    func testStation() -> Void
    {
        let expectation = XCTestExpectation(description: "Bicimad Station (get)...")

        let publisher = EMTClient.shared.bicimadStation(identifier: 4)?
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {                        
                        print("# \(error.localizedDescription)")
                        XCTFail(error.localizedDescription)
                    }
                    
                    expectation.fulfill()
                },
                receiveValue: { station in 
                    print("(\(#function)) Recuperados datos de la estación BICIMAD \(station)")
                    XCTAssertFalse(station.name.isEmpty)
                }
            )

        self.wait(for: [ expectation ], timeout: 10.0)
    }

    /// Los tests que ejecutamos sobre Bicimad
    static var allTests = [
        ("testStations", testStations),
        ("testStation", testStation)
    ]
}