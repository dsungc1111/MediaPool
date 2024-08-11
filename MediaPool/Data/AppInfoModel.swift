//
//  AppInfoModel.swift
//  MediaPool
//
//  Created by 최대성 on 8/11/24.
//

import Foundation


struct Results: Decodable {
    let trackId: Int
    let trackName: String // 앱 이름
    let artworkUrl100: String // 앱 사진
    let artistName: String // 회사 이름
    let screenshotUrls: [String]
    let description: String
    let releaseNotes: String
    let genres: [String]
    let averageUserRatingForCurrentVersion: Double
}

struct Content: Decodable {
    let results: [Results]
}


