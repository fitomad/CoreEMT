import XCTest
@testable import CoreEMT

final class ParkingsTests: XCTestCase 
{
    /** 
        Recuperamos todas las estaciones de Bicimad
    */
    func testParkings() -> Void
    {
        let expectation = XCTestExpectation(description: "Parkings con plazas libres (list)...")

        let publisher = EMTClient.shared.parkings()?
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {
                        print(error.localizedDescription)
                        XCTFail(error.localizedDescription)
                    }

                    expectation.fulfill()
                },
                receiveValue: { parkings in 
                    print("#(\(#function)) Parkings disponibles: \(parkings.count)")

                    XCTAssertFalse(parkings.isEmpty)
                }
            )

        self.wait(for: [ expectation ], timeout: 10.0)
    }

    /** 
        Recuperamos una estación de Bicimad
    */
    func testParking() -> Void
    {
        let expectation = XCTestExpectation(description: "# Detalle de un Parking (get)...")

        let publisher = EMTClient.shared.parking(withIdenfifier: 501)?
            .sink(receiveCompletion: { completion in 
                    if case .failure(let error) = completion
                    {                        
                        print(error.localizedDescription)
                        XCTFail(error.localizedDescription)
                    }
                    
                    expectation.fulfill()
                },
                receiveValue: { parking in 
                    print("#(\(#function)) Datos para el parking \(parking)")
                    XCTAssertFalse(parking.name.isEmpty)
                }
            )

        self.wait(for: [ expectation ], timeout: 10.0)
    }

    func testParkingsAll() -> Void
    {
        let parkingIdentifiers = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37, 39, 40, 41, 42, 43, 44, 45, 46, 47, 49, 50, 51, 52, 53, 54, 55, 58, 60, 61, 62, 63, 64, 67, 68, 69, 71, 72, 73, 75, 77, 86, 88, 89, 501 ]
        
        var expectations = [XCTestExpectation]()

        for parkingIdentifier in parkingIdentifiers
        {
            let expectation = XCTestExpectation(description: "# Detalle del Parking (\(parkingIdentifier))")
            expectations.append(expectation)

            let publisher = EMTClient.shared.parking(withIdenfifier: parkingIdentifier)?
                .sink(receiveCompletion: { completion in 
                        if case .failure(let error) = completion
                        {                        
                            print(error.localizedDescription)
                            //XCTFail(error.localizedDescription)
                        }
                        
                        expectation.fulfill()
                    },
                    receiveValue: { parking in 
                        print("#(\(#function)) Datos para el parking \(parking.name)")
                        XCTAssertFalse(parking.name.isEmpty)
                    }
                )
        }

        self.wait(for: expectations, timeout: 5.0)
    }

    /// Los tests que ejecutamos sobre Bicimad
    static var allTests = [
        ("testParkings", testParkings),
        ("testParking", testParking),
        ("testParkingsAll", testParkingsAll)
    ]
}