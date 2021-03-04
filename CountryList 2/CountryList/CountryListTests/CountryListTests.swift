//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Eric on 4/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Game Class Tests
    
    // Confirm that the Game initializer returns a Game object when passed valid parameters.
    func testGameInitializationSucceeds() {
        // Zero rating
        let zeroRatingGame = Game.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingGame)
        
        // Highest positive rating
        let positiveRatingGame = Game.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingGame)
    }
    
    // Confirm that the Game initialier returns nil when passed a negative rating or an empty name.
    func testGameInitializationFails() {
        // Negative rating
        let negativeRatingGame = Game.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingGame)
        
        // Rating exceeds maximum
        let largeRatingGame = Game.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingGame)
        
        // Empty String
        let emptyStringGame = Game.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringGame)
    }
    
}
