//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2020/12/18.
//

import Foundation

struct NewGameContent: Decodable {
    let formalName: String
    let heroBannerURL: String
    let gameId: Int
    let screenshots: [NewGameScreenshot]
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case gameId = "id"
        case screenshots
    }
    struct NewGameScreenshot: Decodable {
        let images: [NewGameImages]
    }
    struct NewGameImages: Decodable {
        let url: String
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
