//
//  PlayViewController.swift
//  KartRush
//
//  Created by user148325 on 12/2/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import UIKit
import SceneKit

class PlayViewController: UIViewController {
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var rankIcon: UIImageView!
    @IBOutlet weak var sceneView: SCNView!
    
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updatePlayerInfo()
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func startRace(_ sender: UIButton) {
    }
    
    func updatePlayerInfo() {
        //Get the player info from firestore
        PlayerManager.shared.getPlayer(email: player.email){
            gottenPlayer in
                self.player = gottenPlayer
        }
        self.nickname.text = player.nickname
        
        determinateRank(rank: player.rank)
        
        // If you don't want to fix manually the lights
        //        sceneView.autoenablesDefaultLighting = true
        
        // Allow user to manipulate camera
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
    
    func determinateRank(rank: Int) {
        var fixedRank = rank
        if rank < 0{
            fixedRank = 0
        }
        if rank > 3200 {
            fixedRank = 3200
        }
        
        switch fixedRank {
        case 0..<150:
            rankIcon.image = UIImage(named: "copper1")
        case 150..<300:
            rankIcon.image = UIImage(named: "copper2")
        case 300..<450:
            rankIcon.image = UIImage(named: "copper3")
        case 450..<600:
            rankIcon.image = UIImage(named: "emerald1")
        case 600..<750:
            rankIcon.image = UIImage(named: "emerald2")
        case 750..<900:
            rankIcon.image = UIImage(named: "emerald3")
        case 900..<1000:
            rankIcon.image = UIImage(named: "emerald4")
        case 1000..<1200:
            rankIcon.image = UIImage(named: "gold1")
        case 1200..<1400:
            rankIcon.image = UIImage(named: "gold2")
        case 1400..<1600:
            rankIcon.image = UIImage(named: "gold3")
        case 1600..<1800:
            rankIcon.image = UIImage(named: "zafiro1")
        case 1800..<2000:
            rankIcon.image = UIImage(named: "zafiro2")
        case 2000..<2200:
            rankIcon.image = UIImage(named: "zafiro3")
        case 2200..<2400:
            rankIcon.image = UIImage(named: "ruby1")
        case 2400..<2600:
            rankIcon.image = UIImage(named: "ruby2")
        case 2600..<2800:
            rankIcon.image = UIImage(named: "ruby3")
        case 2800..<3000:
            rankIcon.image = UIImage(named: "master")
        case 3000..<3200:
            rankIcon.image = UIImage(named: "king")
        default:
            rankIcon.image = UIImage(named: "copper2")
        }
    }

}
