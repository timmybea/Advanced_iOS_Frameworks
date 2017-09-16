//: Playground - noun: a place where people can play

import UIKit

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
    
}



protocol Explorer {
    var numberOfSensors: Int { get }
}

protocol Civilian {
    var quarterCount: Int { get set }
}

struct Starship: WarpCapable, Explorer, Civilian {
    
    var topSpeed: Double = 9.6
    let numberOfSensors: Int = 10
    var quarterCount: Int = 256
    
}

//because the number of sensors is a constant that has already been set, it is not available in the struct init method.

let enterprise = Starship()
let voyager = Starship(topSpeed: 9.975, quarterCount: 2)

voyager.isFaterThan(item: enterprise)


