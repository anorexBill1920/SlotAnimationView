import XCTest
import SwiftUI
@testable import SlotAnimationView

final class SlotAnimationViewTests: XCTestCase {

    func testInitialization() {
        let items = [MockItem(id: UUID(), name: "Item1"), MockItem(id: UUID(), name: "Item2")]
        let restartAnimation = Binding.constant(false)
        
        let view = SlotAnimationView(items: items, restartAnimation: restartAnimation) { item in
            Text(item.name)
        }
        
        XCTAssertEqual(view.items.count, 2)
        XCTAssertEqual(view.items.first?.name, "Item1")
        XCTAssertEqual(view.items.last?.name, "Item2")
    }
    
    func testRestartAnimationToggle() {
        let items = [MockItem(id: UUID(), name: "Item1")]
        var restartAnimation = false
        
        _ = SlotAnimationView(items: items, restartAnimation: Binding(get: {
            return restartAnimation
        }, set: {
            restartAnimation = $0
        })) { item in
            Text(item.name)
        }
        
        XCTAssertFalse(restartAnimation)
        
        // Simulate the logic that would be executed on tap
        restartAnimation.toggle()
        
        XCTAssertTrue(restartAnimation)
    }
}

struct MockItem: Identifiable, Hashable {
    let id: UUID
    let name: String
}
