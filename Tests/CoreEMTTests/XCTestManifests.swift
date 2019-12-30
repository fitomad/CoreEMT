import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CoreEMTTests.allTests),
        testCase(EMTBicimadTests.allTests),
        testCase(ParkingsTest.allTests),
        testCase(TestBus.allTests),
        testCase(IncidentsTest.allTests)
    ]
}
#endif
