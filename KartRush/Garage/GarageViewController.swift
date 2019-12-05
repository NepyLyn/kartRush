//
//  GarageViewController.swift
//  KartRush
//
//  Created by user148325 on 12/3/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import UIKit
import SceneKit

class GarageViewController: UIViewController {

    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var speedProgressBar: UIProgressView!
    @IBOutlet weak var weightProgressBar: UIProgressView!
    @IBOutlet weak var tractionProgressBar: UIProgressView!	
    @IBOutlet weak var actualCarIndex: UILabel!
    
    @IBOutlet weak var sceneView: SCNView!
    
    var player: Player!
    var actualIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlayerInfo()

        // Do any additional setup after loading the view.
    }
    
    func updatePlayerInfo() {
        //Get the player info from firestore
        PlayerManager.shared.getPlayer(email: player.email){
            gottenPlayer in
            self.player = gottenPlayer
        }
        
        carNameLabel.text = player.actualCar
        var index = 0
        for vehicle in player.garage{
            if vehicle == player.actualCar{
                actualIndex = index
                break
            }
            index += 1
        }
        let s1 = "[" + index.description
        let s2 = s1 + " / "
        let s3 = s2 + player.garage.count.description
        let s4 = s3 + "]"
        self.actualCarIndex.text = s4
        
        actualCarIndex.text = ""
        let vehicle = VehicleManager.shared.GetAvaibleVehicle(name: player.garage[actualIndex])
        speedProgressBar.setProgress(vehicle!.speed, animated: true)
        weightProgressBar.setProgress((vehicle!.weight), animated: true)
        tractionProgressBar.setProgress(vehicle!.traction, animated: true)
        
        
        
        
        
        sceneView.allowsCameraControl = true
        
        // Show FPS logs and timming
        // sceneView.showsStatistics = true
        
        // Set background color
        sceneView.backgroundColor = UIColor.clear
        
        // Allow user translate image
        sceneView.cameraControlConfiguration.allowsTranslation = false
        
        // Set scene settings
        sceneView.scene = VehicleManager.shared.createSceneToVehicle(vehicleName: player.actualCar)
        
    }

}
