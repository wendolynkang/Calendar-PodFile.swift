//
//  Task.swift
//  Calendar
//
//  Created by Wendolyn Kang on 30/10/18.
//  Copyright © 2018 Wendolyn Kang. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    var uuid: String
    var name: String
    var completed: Bool
    var addedBy: String
    var ref: DatabaseReference?
    
    func toDictionary() -> Any {
        return [
            "uuid": uuid,
            "name": name,
            "completed": completed,
            "addedBy": addedBy
        ]
    }
}
