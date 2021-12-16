//
//  PostWorker.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import Foundation
import Combine

class PostWorker {
    
    static let shared = PostWorker()
    
    func getAllPost() -> AnyPublisher<[PostModel], Error> {
        let request = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        guard let request = request else {
            return Fail(error: URLError(.badURL))
                    .eraseToAnyPublisher()
        }

        return WorkerManager.shared.callAPI(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
}
