//
//  DownloadInfoModel.swift
//  MediaPool
//
//  Created by 최대성 on 8/11/24.
//

import Foundation
import RealmSwift


final class DownloadInfoModel: Object {
    
    
    @Persisted(primaryKey: true) var trackId: Int
    @Persisted var trackname: String
    @Persisted var isDownload: Bool
    
    convenience init(trackId: Int, trackname: String, isDownload: Bool) {
        self.init()
        
        self.trackId = trackId
        self.trackname = trackname
        self.isDownload = isDownload
    }
}
