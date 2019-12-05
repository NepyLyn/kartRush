//
//  Race.swift
//  KartRush
//
//  Created by user148325 on 12/1/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import Foundation

enum GameMode {
    case casual
    case ranked
    case event
}

class Race {
    var runners: [Runner]
    let track: String
    var timeLeft: Float
    let gameMode: GameMode
    
    init(runners: [Runner], track: String, timeLeft: Float, gameMode: GameMode) {
        self.runners = runners
        self.track = track
        self.timeLeft = timeLeft
        self.gameMode = gameMode
    }
}


