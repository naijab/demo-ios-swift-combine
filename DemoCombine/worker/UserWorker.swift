//
//  UserWorker.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import Foundation
import Combine

class UserWorker {
    
    static let shared = UserWorker()
    
    func getUser(by id: Int) -> AnyPublisher<UserModel, Error> {
        let request = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")
        
        guard let request = request else {
            return Fail(error: URLError(.badURL))
                    .eraseToAnyPublisher()
        }

        return WorkerManager.shared.callAPI(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
}
