//
//  File.swift
//  KartRush
//
//  Created by user148325 on 12/1/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class Player {
    let ID: String
    var nickname: String
    var email: String
    var seasonedPass: Bool
    var friends: [String]
    var rank: Int
    var garage: [String]
    var actualCar: String
    var profilePictureURL: String
    let isHereSince: Date
    
    init(email: String, nickname:String) {
        self.ID = PlayerManager.shared.GenerateNewID()
        self.nickname = nickname
        self.email = email
        self.seasonedPass = false
        self.friends = [String]()
        self.rank = 0
        self.garage = [String]()
        self.actualCar = VehicleManager.shared.defaultVehicle.name
        self.garage.append(VehicleManager.shared.defaultVehicle.name)
        self.profilePictureURL = "default"
        self.isHereSince = Date()
    }
    
    init(ID: String, nickname:String, email:String, seasonedPass:Bool, friends:[String], rank:Int, garage: [String], actualCar:String, profilePictureURL:String, isHereSince:Date) {
        self.ID = ID
        self.nickname = nickname
        self.email = email
        self.seasonedPass = seasonedPass
        self.friends = friends
        self.rank = rank
        self.garage = garage
        self.actualCar = actualCar
        self.profilePictureURL = profilePictureURL
        self.isHereSince = isHereSince
    }
}

class PlayerManager {
    static let shared = PlayerManager()
    var totalPlayers = 0
    var ref: DocumentReference!
    var db: Firestore!
    
    private init() {
        self.totalPlayers = 0
    }
    
    func GenerateNewID() -> String{
        self.totalPlayers += 1
        return totalPlayers.description
    }
    
    func encodePlayerToFirebase(player: Player) -> [String: Any] {
        let data: [String: Any] = [
            "ID": player.ID,
            "nickname": player.nickname,
            "email": player.email,
            "seasonedPass": player.seasonedPass,
            "friends": player.friends,
            "rank": player.rank,
            "garage": player.garage,
            "actualCar": player.actualCar,
            "profilePictureURL": player.profilePictureURL,
            "isHereSince": player.isHereSince]
        return data
    }
    
    func savePlayerInFirebase(newPlayer: Player) {
        db = Firestore.firestore()
        let dataToSave = PlayerManager.shared.encodePlayerToFirebase(player: newPlayer)
        
        ref = db.collection("Players").addDocument(data: dataToSave, completion: {(error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            else{
                print("Guardado exitoso")
            }
        })
        
    }
    
    func getPlayer(email: String, _ completion: @escaping (Player) -> ()) {
        db = Firestore.firestore()
        db.collection("Players").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let gottenPlayer = self.decodePlayerFromFireBase(firebaseData: document.data())
                        completion(gottenPlayer)
                    }
                }
        }
    }
    
//    func getPlayerFromFirebase(email: String) -> Player {
//        db = Firestore.firestore()
//        db.collection("cities").whereField("capital", isEqualTo: true)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                        return Player(email: email, nickname: "asd")
//                    }
//                }
//        }
//    }
    
    func decodePlayerFromFireBase(firebaseData: [String:Any]) -> Player {
        
        let ID = firebaseData["ID"] as? String ?? "No info"
        let nickname = firebaseData["nickname"] as? String ?? "No info"
        let email = firebaseData["email"] as? String ?? "No info"
        let seasonedPass = firebaseData["seasonedPass"] as? Bool ?? false
        let friends = firebaseData["friends"] as? [String] ?? [String]()
        let rank = firebaseData["rank"] as? Int ?? 0
        let garage = firebaseData["garage"] as? [String] ?? [String]()
        let actualCar = firebaseData["actualCar"] as? String ?? "defautl"
        let profilePicture = firebaseData["profilePictureURL"] as? String ?? ""
        let isHereSince = firebaseData["isHereSince"] as? Date ?? Date()

        let gottenPlayer = Player(ID: ID, nickname: nickname, email: email, seasonedPass: seasonedPass, friends: friends, rank: rank, garage: garage, actualCar: actualCar, profilePictureURL: profilePicture, isHereSince: isHereSince)
        return gottenPlayer
    }
    
    
}


