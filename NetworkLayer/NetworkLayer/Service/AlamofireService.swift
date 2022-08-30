//
//  AlamofireService.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation
import Alamofire

protocol AlamofireServiceProtocol: AnyObject {
    func fetchData(_ route: HTTPEndPointType, completion: @escaping(Result<Data>) -> Void )
  
}

final class AlamofireService: AlamofireServiceProtocol {
    func fetchData(_ route: HTTPEndPointType, completion: @escaping(Result<Data>) -> Void) {
        let request = buildRequest(from: route)
        request.responseData { (dataResponse) in
            switch dataResponse.result {
            case .failure(let error):
                completion(.error(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    fileprivate func buildRequest(from route: HTTPEndPointType) -> DataRequest {
        let urlString = route.baseURL + route.path
        let request = AF.request(urlString,
                                 method: route.method,
                                 parameters: route.param,
                                 headers: route.header,
                                 interceptor: nil,
                                 requestModifier: { $0.timeoutInterval = 10 })
        return request
    }
}
