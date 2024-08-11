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
    
    init() {
        
        do {
            realm = try Realm()
        } catch {
            print("램 초기화 실패")
            realm = nil
        }
    }
    
    func detectRealmURL() {
        print(realm?.configuration.fileURL ?? "")
    }
    
    
    
}
