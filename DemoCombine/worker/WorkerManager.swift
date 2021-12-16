//
//  WorkerManager.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import Foundation
import Combine

enum APIFailureCondition: Error {
    case invalidServerResponse
}

struct Response<T> {
    let value: T
    let response: URLResponse
}

class WorkerManager {
    
    static let shared = WorkerManager()
    
    func callAPI<T: Decodable>(_ url: URL) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Response<T> in

                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("status code for api response : \((result.response as? HTTPURLResponse)?.statusCode ?? 200)")
                    throw APIFailureCondition.invalidServerResponse
                }

                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
