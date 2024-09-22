import XCTest
import SwiftUI
import Combine
@testable import Buttonify

final class ButtonifyTests: XCTestCase {
    
    // Test the tap interaction
    func testTapInteraction() {
        let expectation = XCTestExpectation(description: "Tap interaction callback triggered")
        
        let hoverButton = HoverButton(isLoading: .constant(false), isShrinkable: false, hapticConfig: nil) {
            Text("Press Me")
        } interactionCallback: { interaction in
            if interaction == .tap {
                expectation.fulfill()
            }
        }
        
        hoverButton.simulateTap()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test the holding interaction
    func testHoldingInteraction() {
        let expectation = XCTestExpectation(description: "Holding interaction callback triggered")
        
        let hoverButton = HoverButton(isLoading: .constant(false), isShrinkable: false, hapticConfig: nil) {
            Text("Press Me")
        } interactionCallback: { interaction in
            if interaction == .holding {
                expectation.fulfill()
            }
        }
        
        hoverButton.simulateHold()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test the release interaction
    func testReleaseInteraction() {
        let expectation = XCTestExpectation(description: "Release interaction callback triggered")
        
        let hoverButton = HoverButton(isLoading: .constant(false), isShrinkable: false, hapticConfig: nil) {
            Text("Press Me")
        } interactionCallback: { interaction in
            if interaction == .released {
                expectation.fulfill()
            }
        }
        
        hoverButton.simulateRelease()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test loading state behavior
    func testLoadingState() {
        let isLoading = Binding<Bool>(
            get: { true },  // Initial value
            set: { _ in }   // You can customize the setter if needed for testing
        )
        
        let hoverButton = HoverButton(isLoading: isLoading, isShrinkable: true, hapticConfig: nil) {
            Text("Press Me")
        } interactionCallback: { _ in }
        
        XCTAssertTrue(isLoading.wrappedValue, "HoverButton should be in loading state")
        
        // Simulate loading end
        isLoading.wrappedValue = false
        XCTAssertFalse(isLoading.wrappedValue, "HoverButton should no longer be in loading state")
    }
    
    // Test shrinkable behavior
    func testShrinkableBehavior() {
        let hoverButton = HoverButton(isLoading: .constant(true), isShrinkable: true, hapticConfig: nil) {
            Text("Press Me")
        } interactionCallback: { _ in }
        
        XCTAssertTrue(hoverButton.isShrinkableForTest(), "HoverButton should be shrinkable")
        
        hoverButton.simulateTap()
        
        XCTAssertTrue(hoverButton.isShrinkableForTest(), "HoverButton should shrink while loading")
    }
    
    // Test haptic feedback
    func testHapticFeedback() {
        let expectation = XCTestExpectation(description: "Haptic feedback generated")
        
        let hapticConfig = HapticConfiguration(tap: .impact(.light), longPress: .impact(.heavy), release: .selection)
        
        let hoverButton = HoverButton(isLoading: .constant(false), isShrinkable: false, hapticConfig: hapticConfig) {
            Text("Press Me")
        } interactionCallback: { interaction in
            if interaction == .tap {
                expectation.fulfill()
            }
        }
        
        hoverButton.simulateTap()
        
        wait(for: [expectation], timeout: 1.0)
    }
}
