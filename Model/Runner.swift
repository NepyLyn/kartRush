//
//  Runner.swift
//  KartRush
//
//  Created by user148325 on 12/1/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import Foundation

class Runner {
    let Player: Player
    var position: Int8
    let usingVehicle: Vehicle
    
    init(player: Player, usingVehicle: Vehicle) {
        self.Player = player
        self.position = 0
        self.usingVehicle = usingVehicle
    }
}
