//
//  ServiceUrl.swift
//  TesterAbly
//
//  Created by antonius krisna sahadewa on 04/08/23.
//

import Foundation

enum BuildMode {
    case dev
    case staging
    case prod
}

enum BuildModeUrl: String, Encodable{
    case dev = "Dev"
    case vega = "Staging"
    case orion = "Prod"
}
    
struct BuildModeEndpoint {
    //Dev
    static let buildMode : BuildMode = .dev
}

enum BaseSocketUrl: String {
    case dev = "https://chronos-dev.perqara.com"
    case staging = "https://chronos-staging.perqara.com"
    case prod = "https://chronos.perqara.com"
}

enum BaseMsgSocketUrl: String {
    case dev = "https://chronos-dev.perqara.com/consultation"
    case staging = "https://chronos-staging.perqara.com/consultation"
    case prod = "https://chronos.perqara.com/consultation"
}

var socketBaseUrl: String {
    switch BuildModeEndpoint.buildMode {
        case .dev:
            return "\(BaseSocketUrl.dev.rawValue)/"
        case .staging:
            return "\(BaseSocketUrl.staging.rawValue)/"
        case .prod :
            return "\(BaseSocketUrl.prod.rawValue)/"
    }
}

var socketMsgBaseUrl: String {
    switch BuildModeEndpoint.buildMode {
        case .dev:
            return "\(BaseMsgSocketUrl.dev.rawValue)/"
        case .staging:
            return "\(BaseMsgSocketUrl.staging.rawValue)/"
        case .prod :
            return "\(BaseMsgSocketUrl.prod.rawValue)/"
    }
}
