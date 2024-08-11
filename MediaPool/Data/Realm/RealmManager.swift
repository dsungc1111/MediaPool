//
//  RealmManager.swift
//  MediaPool
//
//  Created by 최대성 on 8/11/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    private let realm: Realm?
//    private let realm = try! Realm()
    init() {
        
        do {
            realm = try Realm()
        } catch {
            print("램 초기화 실패")
            realm = nil
        }
    }
//    
    func detectRealmURL() {
        print(realm?.configuration.fileURL ?? "")
    }
    
    func fetchDownloadedApp() -> [DownloadInfoModel] {
        if let value = realm?.objects(DownloadInfoModel.self) {
            return Array(value)
        } else { return [] }
    }
    
    func saveApp(element: Results) {
        print(#function)
        guard let realm = realm else { return }
        
        do {
            try realm.write {
                realm.create(DownloadInfoModel.self, value: ["trackId" : element.trackId, "trackname" : element.trackName ])
            }
        } catch {
            print("안될때")
        }
       
        
    }
    
    
}
