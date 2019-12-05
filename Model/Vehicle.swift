//
//  Vehicle.swift
//  KartRush
//
//  Created by user148325 on 12/1/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import Foundation
import SceneKit

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
    override init(name: String, model: String, speed: Float, weight: Float, traction: Float) {
        super.init(name: name, model: model, speed: speed, weight: weight, traction: traction)
    }
}

class Motorcycle: Vehicle {
    override init(name: String, model: String, speed: Float, weight: Float, traction: Float) {
        super.init(name: name, model: model, speed: speed, weight: weight, traction: traction)
    }
}

class EspecialVehicle: Vehicle {
    override init(name: String, model: String, speed: Float, weight: Float, traction: Float) {
        super.init(name: name, model: model, speed: speed, weight: weight, traction: traction)
    }
}


class VehicleManager {
    static let shared = VehicleManager()
    var avaibleVehicles: [Vehicle]
    let defaultVehicle = Car(name: "Starter", model: "default", speed: 0.5, weight: 0.8, traction: 0.85)
    
    private init() {
        avaibleVehicles = [Vehicle]()
        avaibleVehicles.append(defaultVehicle)
    }
    
    func createSceneToVehicle(vehicleName: String) -> SCNScene {
        // 1: Load .obj file
        let scene = SCNScene(named:  vehicleName + ".obj")
        
        // 2: Add camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        // 3: Place camera
        cameraNode.position = SCNVector3(x: 0, y: 1.5, z: 2)
        // 4: Set camera on scene
        scene?.rootNode.addChildNode(cameraNode)
        
        // 5: Adding light to scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 1.5, z: -2)
        scene?.rootNode.addChildNode(lightNode)
        
        // 6: Creating and adding ambien light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        return scene!
    }
    
    func GetAvaibleVehicle(name: String) -> Vehicle?{
        if let vehicle = avaibleVehicles.first(where: {$0.name == name}){
            return vehicle
        }
        return nil
    }
}

