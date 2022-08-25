//
//  HttpEndPointType.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 25.08.2022.
//

import Foundation
import Alamofire

protocol HTTPEndPointType {
    var baseURL: String { get }
    var path: String { get }
    var header: HTTPHeaders? { get }
    var method: HTTPMethod { get }
    var param: Parameters? { get }
}
