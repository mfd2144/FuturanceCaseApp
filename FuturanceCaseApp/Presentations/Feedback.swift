//
//  Feedback.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 26.08.2022.
//

import Foundation

enum Feedback {
    case info(String)
    case caution(String)
    case success(String)
    case error(String)
    
    var title: String {
        switch self {
        case .info:
            return "Bilgi"
        case .caution:
            return "İkaz"
        case .success:
            return "Başarılı"
        case .error:
            return "Hata"
        }
    }
    var returnContainer: String {
        switch self {
        case .info(let string):
            return string
        case .caution(let string):
            return string
        case .success(let string):
            return string
        case .error(let string):
            return string
        }
    }
}
