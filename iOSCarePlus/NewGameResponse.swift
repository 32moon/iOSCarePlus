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
    let gameId: Int
    let screenshots: [NewGameScreenshots]?
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case gameId = "id"
        case screenshots
    }
    struct NewGameScreenshots: Decodable {
        let images: [NewGameURL]
    }
    
    struct NewGameURL: Decodable {
        let url: String
    }
}
