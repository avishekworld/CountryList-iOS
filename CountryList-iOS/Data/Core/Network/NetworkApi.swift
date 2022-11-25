//
//  NetworkApi.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/8/22.
//

import Foundation

// Network Api
protocol NetworkApi {
    /**
     Get network call.
     
     - parameter request: Get Request
     - returns: Result of either Response or Error
     
     */
    func get(request: GetRequest) async -> Result<Response, Error>
}

// Network Api Url Session
class NetworkApiUrlSession : NetworkApi {
    
    func get(request: GetRequest) async -> Result<Response, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: request.url)!)
            return Result.success(Response(data: data))
        } catch {
            return Result.failure(error)
        }
    }
}

// Get Request
struct GetRequest {
    let url: String
}

// Post Request
struct PostRequest {
    let url: String
    let payload: Dictionary<String, String>
}

// Response
struct Response {
    let data: Data
}
