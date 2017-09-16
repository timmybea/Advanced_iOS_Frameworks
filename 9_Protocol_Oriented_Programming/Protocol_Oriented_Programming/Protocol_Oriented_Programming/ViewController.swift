//
//  ViewController.swift
//  Protocol_Oriented_Programming
//
//  Created by Tim Beals on 2017-09-15.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //because the number of sensors is a constant that has already been set, it is not available in the struct init method.
        
        let enterprise = Starship()
        let voyager = Starship(topSpeed: 9.975, quarterCount: 2)
        
        var result = voyager.isFaterThan(item: enterprise)
        print("Voyager is faster than Enterprise? \(result)")
        
        result = voyager.hasMoreQuarters(item: enterprise)
        print("Voyager has more quarters than Enterprise? \(result)")
        
        //Now let's add a non-civilian ship
        let newShip = NonCivilianShip()
        //noticee that you cannot now use newShip.hasMoreQuarters because, even though it conforms to the WarpCapable protocol, it doesn't conform to the Civilian protocol.
        
        
        //Let's check out this cool Collection extension defined below...
        let shipOne = Starship(topSpeed: 9.3, quarterCount: 400)
        let shipTwo = Starship(topSpeed: 8.6, quarterCount: 300)
        let shipThree = Starship()
        
        let ships = [shipOne, shipTwo, shipThree]
        
        var speed = ships.averageTopSpeed() //This is from the Collection extension. Cool!
        print("The average top speed is: \(speed)")
    }
}



//Note that the get and set keywords indicate whether you would like a variable or constant.

protocol WarpCapable {
    var topSpeed: Double { get set }
}

//Now let's add another function to the protocol
extension WarpCapable {
    func isFaterThan(item: WarpCapable) -> Bool {
        return self.topSpeed > item.topSpeed
    }
}

//And this time, we are adding a protocol function, but only if the type that has conformed to the WarpCapable protocol has also conformed to the Civilian protocol.
extension WarpCapable where Self:Civilian {
    func hasMoreQuarters(item: Self) -> Bool {
        return self.quarterCount > item.quarterCount
    }
}

protocol Explorer {
    var numberOfSensors: Int { get }
}

protocol Civilian {
    var quarterCount: Int { get set }
}

struct NonCivilianShip: WarpCapable, Explorer {
    
    var topSpeed: Double = 9.7
    var numberOfSensors: Int = 8
}

struct Starship: WarpCapable, Explorer, Civilian {
    
    var topSpeed: Double = 9.6
    let numberOfSensors: Int = 10
    var quarterCount: Int = 200

}

//We begin to see even more value when we extend existing classes that conform to a protocol.

extension Collection where Self.Iterator.Element : WarpCapable {
    
    func averageTopSpeed() -> Double {
        
        var total: Double = 0, count: Double = 0
        
        for item in self {
            
            total += item.topSpeed
            count += 1
        }
        
        let result: Double = total / count
        return result
    }
}







