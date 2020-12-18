//
//  Post.swift
//  InstagramApp2
//
//  Created by 野津天志 on 2020/12/17.
//

import Foundation
import Firebase

struct Post {             //クラスとは違い、継承はできない  //クラスが参照型であるのに対して構造体は値型
    let content: String                    //投稿の文章
    let postID: String                     //投稿それぞれのID
    let senderID: String                   //投稿者のUserID
    let createdAt: Timestamp               //投稿が作成された時間
    let updatedAt: Timestamp               //投稿が更新された時間
    
    init(data: [String: Any]) {
        content = data["content"] as! String
        postID = data["postID"] as! String
        senderID = data["senderID"] as! String
        createdAt = data["createdAt"] as! Timestamp
        updatedAt = data["updatedAt"] as! Timestamp
    }
    
}
