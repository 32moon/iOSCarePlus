//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2020/12/18.
//

import Foundation

struct NewGameResponse: Decodable {
    let contents: [NewGameContent]
    let length: Int
    let offset: Int
    let total: Int
}

struct NewGameContent: Decodable {
    let formalName: String
    let heroBannerURL: String
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
    }
}

