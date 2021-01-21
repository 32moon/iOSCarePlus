//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2020/12/18.
//

import Foundation

struct Images: Decodable {
    let url: String
}

struct Screenshots: Decodable {
    let images: [Images]
}

struct NewGameContent: Decodable {
    let formalName: String
    let heroBannerURL: String
    let gameId: Int
    let screenshots: [Screenshots]
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case gameId = "id"
        case screenshots
    }
    struct NewGameURL: Decodable {
        let url: String
    }
}

struct NewGameResponse: Decodable {
    var contents: [NewGameContent]
    let length: Int
    let offset: Int
    let total: Int
}
