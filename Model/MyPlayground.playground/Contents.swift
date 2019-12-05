import UIKit

class Vehicle {
    let name: String
    let model: String
    var speed: Float
    var weight: Float
    var traction: Float
    
    init(name: String, model: String, speed:Float, weight: Float, traction: Float) {
        self.name = name
        self.model = model
        self.speed = speed
        self.weight = weight
        self.traction = traction
    }
}

class Car: Vehicle {
    var wheels: Int
    
    init(name: String, model: String, speed: Float, weight: Float, traction: Float, wheels: Int) {
        self.wheels = wheels
        super.init(name: name, model: model, speed: speed
            , weight: weight, traction: traction)
    }
}

class Motorcycle: Vehicle {
    
}

class EspecialVehicle: Vehicle {
    
}


class VehicleManager {
    static let shared = VehicleManager()
    var avaibleVehicles: [Vehicle]
    let defaultVehicle = Car(name: "Starter", model: "default", speed: 1, weight: 1, traction: 1, wheels: 6)
    
    private init() {
        avaibleVehicles = [Vehicle]()
        avaibleVehicles.append(defaultVehicle)
    }
    
    func GetAvaibleVehicle(name: String) -> Vehicle?{
        if let vehicle = avaibleVehicles.first(where: {$0.name == name}){
            return vehicle
        }
        return nil
    }
}

var vehicleArray: [Vehicle] = []
let newCar = Car(name: "test", model: "dafault", speed: 0.5, weight: 0.5, traction: 0.5, wheels: 10)

vehicleArray.append(newCar)

let gotVehicle = vehicleArray[0]
print(type(of: gotVehicle))

