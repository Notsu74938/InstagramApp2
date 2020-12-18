//
//  AppUser.swift
//  InstagramApp2
//
//  Created by 野津天志 on 2020/12/17.
//

import Foundation
import Firebase

struct AppUser {            //UserモデルだとFirebaseAuthのUserクラスとかぶる
    let userID: String                 //FirebaseAuthのユーザーID
    let userName: String               //ユーザーの名前

    init(data: [String: Any]) {
        userID = data["userID"] as! String
        userName = data["userName"] as! String
    }
}




