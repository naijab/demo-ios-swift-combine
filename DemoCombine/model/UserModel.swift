//
//  UserModel.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import Foundation

struct UserModel: Decodable, Hashable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
}
