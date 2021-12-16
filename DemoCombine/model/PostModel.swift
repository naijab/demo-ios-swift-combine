//
//  Post.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import Foundation

struct PostModel: Decodable, Hashable {
    let id: Int?
    let userId: Int?
    var user: UserModel?
    let title: String?
    let body: String?
}
