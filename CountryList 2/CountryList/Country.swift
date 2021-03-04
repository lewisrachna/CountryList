//
//  Country.swift
//  FoodTracker
//
//  Created by Eric on 4/15/19.
//

import UIKit
import os.log


// NSObject and NSCoding are used for storing persist data - i.e. data after closure. May want to use something like Postgres in the future instead



class Country: CustomStringConvertible { // for debugging/printing, from https://stackoverflow.com/questions/36587104/swift-equivalent-of-java-tostring
    
    //MARK: Properties
    
    var id: String // var is different from let - var can change, let cannot
    var name: String
    var citizen: String
    var dates: String
    public var description: String { return "(id: " + id + " | name: " + name + " | citizen: " + citizen + " | dates: " + dates + ")"}
    
    
    //MARK: Initialization
    
    init?(id: String, name: String, citizen: String, dates: String) {
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty

        // Initialize properties
        self.id = id
        self.name = name
        self.citizen = citizen
        self.dates = dates
    }
    
    
}
