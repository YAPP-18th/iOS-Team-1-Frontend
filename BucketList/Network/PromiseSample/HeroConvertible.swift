//
//  HeroConvertible.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/03.
//

import Alamofire
import Foundation

public protocol HeroRequestConvertible: URLRequestConvertible {
    var httpMethod: Alamofire.HTTPMethod { get }
    var path: String { get }
    var fullAPIPath: String { get }
    var mandatoryHeaders: [HeroHeader] { get }
}

public extension HeroRequestConvertible {
    var fullAPIPath: String {
        return "\(HeroConstants.hostName)\(path)"
    }
    
    var mandatoryHeaders: [HeroHeader] {
        return [HeroHeader.authorization, HeroHeader.heroAgent]
    }
}

public protocol HeroResponseConvertible {
    var responseHeaders: [AnyHashable: Any] { get }
    var responseValue: Any? { get }
    var error: HeroAPIError? { get }
    var isSuccess: Bool { get }
}
